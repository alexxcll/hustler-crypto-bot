"""
Hustler Bot - Main FastAPI Application
Advanced Crypto Futures Scalping Bot
"""
import asyncio
import logging
from contextlib import asynccontextmanager
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from fastapi.middleware.gzip import GZipMiddleware
from fastapi.staticfiles import StaticFiles
import uvicorn

from app.core.config import settings
from app.core.database import init_db
from app.api.routes import api_router
from app.services.trading_engine import trading_engine
from app.services.currency_service import currency_service
from app.services.websocket_manager import websocket_manager

# Logging konfigurieren
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
    handlers=[
        logging.FileHandler("logs/hustler-bot.log"),
        logging.StreamHandler()
    ]
)

logger = logging.getLogger(__name__)

@asynccontextmanager
async def lifespan(app: FastAPI):
    """Application lifespan events"""
    # Startup
    logger.info("🚀 Hustler Bot startet...")
    
    # Datenbank initialisieren
    await init_db()
    
    # Services initialisieren
    await trading_engine.initialize()
    await currency_service.initialize()
    await websocket_manager.initialize()
    
    logger.info("✅ Hustler Bot bereit!")
    
    yield
    
    # Shutdown
    logger.info("🛑 Hustler Bot wird heruntergefahren...")
    await trading_engine.shutdown()
    await websocket_manager.shutdown()
    logger.info("✅ Hustler Bot gestoppt")

# FastAPI App erstellen
app = FastAPI(
    title="Hustler Bot API",
    description="Advanced Crypto Futures Scalping Bot API",
    version="1.0.0",
    docs_url="/docs",
    redoc_url="/redoc",
    lifespan=lifespan
)

# Middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.ALLOWED_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.add_middleware(GZipMiddleware, minimum_size=1000)

# Routes
app.include_router(api_router, prefix="/api/v1")

# Static Files
app.mount("/static", StaticFiles(directory="static"), name="static")

# Health Check
@app.get("/health")
async def health_check():
    """System health check"""
    return {
        "status": "healthy",
        "service": "hustler-bot-api",
        "version": "1.0.0",
        "timestamp": "2025-09-09T23:19:00Z"
    }

@app.get("/")
async def root():
    """Root endpoint"""
    return {
        "message": "🚀 Hustler Bot API",
        "description": "Advanced Crypto Futures Scalping Bot",
        "docs": "/docs",
        "health": "/health"
    }

if __name__ == "__main__":
    uvicorn.run(
        "main:app",
        host="0.0.0.0",
        port=settings.PORT,
        reload=settings.DEBUG,
        log_level="info"
    )
