#!/bin/bash

BACKUP_DIR="/tmp/backups/"
echo "Доступные резервные копии:"
ls -1 "$BACKUP_DIR" | grep ^backup-

read -p "Введите имя копии для восстановления: " BACKUP_NAME
rsync -avh "$BACKUP_DIR/$BACKUP_NAME/" /RSYNC/restore
