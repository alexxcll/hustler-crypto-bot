-- Hustler Bot Database Initialization

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users Table
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    hashed_password VARCHAR(100) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    is_superuser BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bot Configurations
CREATE TABLE IF NOT EXISTS bot_configs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id INTEGER REFERENCES users(id),
    name VARCHAR(100) NOT NULL,
    symbol VARCHAR(20) NOT NULL,
    leverage INTEGER DEFAULT 10,
    position_size DECIMAL(15,8) DEFAULT 100.0,
    stop_loss_pct DECIMAL(5,2) DEFAULT 1.0,
    take_profit_pct DECIMAL(5,2) DEFAULT 0.5,
    max_positions INTEGER DEFAULT 5,
    is_active BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trades Table
CREATE TABLE IF NOT EXISTS trades (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id INTEGER REFERENCES users(id),
    config_id UUID REFERENCES bot_configs(id),
    symbol VARCHAR(20) NOT NULL,
    side VARCHAR(10) NOT NULL,
    quantity DECIMAL(15,8) NOT NULL,
    entry_price DECIMAL(15,8) NOT NULL,
    exit_price DECIMAL(15,8),
    pnl DECIMAL(15,8),
    status VARCHAR(20) DEFAULT 'open',
    opened_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    closed_at TIMESTAMP
);

-- Insert demo user
INSERT INTO users (username, email, hashed_password, is_active) 
VALUES ('demo', 'demo@hustlerbot.io', '$2b$12$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31lW', TRUE)
ON CONFLICT (username) DO NOTHING;

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_trades_user_id ON trades(user_id);
CREATE INDEX IF NOT EXISTS idx_trades_symbol ON trades(symbol);
CREATE INDEX IF NOT EXISTS idx_trades_status ON trades(status);
CREATE INDEX IF NOT EXISTS idx_bot_configs_user_id ON bot_configs(user_id);

-- Demo-Konfiguration
INSERT INTO bot_configs (user_id, name, symbol, leverage, position_size) 
SELECT id, 'Demo BTCEUR Scalper', 'BTCEUR', 10, 100.0 
FROM users WHERE username = 'demo'
ON CONFLICT DO NOTHING;
