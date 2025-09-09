#!/bin/bash
# Hustler Bot Restore Script

if [ -z "$1" ]; then
    echo "Usage: ./restore.sh backup_date (z.B. 20250909_231900)"
    exit 1
fi

BACKUP_DIR="./backups"
DATE=$1

echo "📂 Stelle Backup wieder her: $DATE"

# Database Restore
if [ -f "$BACKUP_DIR/db_backup_$DATE.sql" ]; then
    docker-compose exec -T postgres psql -U hustler -d hustler_db < $BACKUP_DIR/db_backup_$DATE.sql
    echo "✅ Datenbank wiederhergestellt"
else
    echo "❌ Datenbank-Backup nicht gefunden"
fi

# Config Restore
if [ -f "$BACKUP_DIR/config_backup_$DATE.tar.gz" ]; then
    tar -xzf $BACKUP_DIR/config_backup_$DATE.tar.gz
    echo "✅ Konfiguration wiederhergestellt"
else
    echo "❌ Konfigurations-Backup nicht gefunden"
fi
