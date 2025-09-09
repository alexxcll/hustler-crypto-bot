#!/bin/bash
# HUSTLER BOT - VOLLSTÄNDIGER INSTALLER

set -e

# Farben
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}🚀 HUSTLER BOT - INSTALLER${NC}"
echo "=============================="

# System erkennen
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="Linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="Mac"
else
    OS="Unknown"
fi

echo -e "${BLUE}ℹ️  System: $OS${NC}"

# Docker prüfen
if ! command -v docker &> /dev/null; then
    echo -e "${YELLOW}⚠️  Docker wird installiert...${NC}"
    if [[ "$OS" == "Linux" ]]; then
        curl -fsSL https://get.docker.com | sh
        sudo systemctl start docker
        sudo usermod -aG docker $USER
    elif [[ "$OS" == "Mac" ]]; then
        echo "Bitte Docker Desktop für Mac installieren: https://docker.com/products/docker-desktop"
        exit 1
    fi
fi

# Projekt herunterladen
echo -e "${BLUE}📥 Lade Hustler Bot herunter...${NC}"
if [ -d "hustler-crypto-bot" ]; then
    cd hustler-crypto-bot && git pull
else
    git clone https://github.com/username/hustler-crypto-bot.git
    cd hustler-crypto-bot
fi

# Environment setup
if [ ! -f ".env" ]; then
    cp .env.example .env
    echo -e "${GREEN}✅ Environment-Datei erstellt${NC}"
    
    echo -e "${YELLOW}🔧 KONFIGURATION${NC}"
    read -p "Bitget API Key (Enter für Demo): " api_key
    if [[ -n "$api_key" ]]; then
        sed -i.bak "s/your_bitget_api_key_here/$api_key/g" .env
    fi
fi

# Services starten
echo -e "${BLUE}🚀 Starte Services...${NC}"
docker-compose up -d

# Warten
echo -e "${YELLOW}⏱️  Warte auf Start (60 Sekunden)...${NC}"
sleep 60

# Abschluss
echo ""
echo -e "${GREEN}🎉 INSTALLATION ERFOLGREICH!${NC}"
echo "============================="
echo ""
echo "🌐 Web Dashboard: http://localhost:3000"
echo "🔧 API Docs: http://localhost:8000/docs"
echo "🔐 Demo Login: demo / demo123"
echo ""
echo "⚙️  Management:"
echo "  Status: docker-compose ps"
echo "  Logs: docker-compose logs -f"
echo "  Stop: docker-compose down"
echo ""

# Browser öffnen
if command -v xdg-open >/dev/null; then
    xdg-open http://localhost:3000
elif command -v open >/dev/null; then
    open http://localhost:3000
fi

echo -e "${GREEN}✅ Hustler Bot läuft!${NC}"
