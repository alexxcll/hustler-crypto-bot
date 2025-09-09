#!/bin/bash
# Hustler Bot Backup Script

BACKUP_DIR="./backups"
DATE=$(date +%Y%m%d_%H%M%S)

mkdir -p $BACKUP_DIR

echo "🗄️  Erstelle Backup: $DATE"

# Database Backup
docker-compose exec -T postgres pg_dump -U hustler hustler_db > $BACKUP_DIR/db_backup_$DATE.sql

# Configuration Backup
tar -czf $BACKUP_DIR/config_backup_$DATE.tar.gz .env docker-compose.yml

echo "✅ Backup erstellt: $BACKUP_DIR/"
