# Logs Directory

Dieses Verzeichnis enthält die Log-Dateien des Hustler Bots:

- `hustler-bot.log` - Haupt-Anwendungslog
- `trading.log` - Trading-spezifische Logs  
- `error.log` - Fehler-Logs
- `access.log` - API-Zugriffs-Logs

## Log-Befehle

```bash
# Live-Logs anzeigen
docker-compose logs -f

# Bestimmten Service
docker-compose logs -f backend

# Letzte 100 Zeilen
docker-compose logs --tail=100
```
