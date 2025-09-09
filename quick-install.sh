#!/bin/bash
# HUSTLER BOT - ULTRA QUICK INSTALLER (1 Minute)

echo "🚀 Hustler Bot wird gestartet..." && \
git clone https://github.com/username/hustler-crypto-bot.git 2>/dev/null || (cd hustler-crypto-bot && git pull) && \
cd hustler-crypto-bot && \
cp .env.example .env && \
docker-compose up -d && \
echo "⏱️  Warte auf Services (45 Sekunden)..." && sleep 45 && \
echo "" && \
echo "🎉 BEREIT! Öffne http://localhost:3000" && \
echo "🔐 Login: demo / demo123" && \
(command -v xdg-open >/dev/null && xdg-open http://localhost:3000) || \
(command -v open >/dev/null && open http://localhost:3000) || \
echo "Öffne http://localhost:3000 in deinem Browser"
