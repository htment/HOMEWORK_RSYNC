#!/bin/bash

# Настройки
SOURCE_DIR="/home/user/"
BACKUP_DIR="/tmp/backup/"
LOG_FILE="/RSYNC/backup_home.log"

# Запуск rsync
rsync -avh --checksum --exclude=.* --delete "$SOURCE_DIR" "$BACKUP_DIR" > "$LOG_FILE" 2>&1

# Проверка статуса выполнения
if [ $? -eq 0 ]; then
    logger "Резервное копирование домашней директории успешно выполнено."
else
    logger "Ошибка при резервном копировании домашней директории! Проверьте $LOG_FILE."
fi
