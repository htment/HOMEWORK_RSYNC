#!/bin/bash

SOURCE="/RSYNC"
BACKUP_DIR="/tmp/backups"
REMOTE="art@192.168.31.112:/home/upload/test"
MAX_BACKUPS=5

# Создаем новую резервную копию с меткой времени
TIMESTAMP=$(date +%Y%m%d%H%M%S)
mkdir -p "$BACKUP_DIR/backup-$TIMESTAMP"
rsync -avh --progress --checksum --exclude '.git' --link-dest="$BACKUP_DIR/latest" "$SOURCE" "$BACKUP_DIR/backup-$TIMESTAMP"

# Обновляем ссылку 'latest'
rm -f "$BACKUP_DIR/latest"
ln -s "backup-$TIMESTAMP" "$BACKUP_DIR/latest"

# Удаляем старые копии (оставляем только последние MAX_BACKUPS)
cd "$BACKUP_DIR" || exit
ls -td backup-* | tail -n +$((MAX_BACKUPS + 1)) | xargs rm -rf

# Копируем на удаленный сервер (опционально)
rsync -avh --progress --exclude '.git' --delete "$BACKUP_DIR" "$REMOTE"
