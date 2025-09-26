#!/bin/bash

# Скрипт резервного копирования домашней директории
# Логирование в системный журнал

LOG_TAG="home-backup"
BACKUP_SOURCE="$HOME"
BACKUP_DEST="/tmp/backup"
RSYNC_OPTIONS="-avh --delete --checksum --exclude='.*/'"

log_message() {
    logger -t "$LOG_TAG" "$1"
    echo "$(date): $1"
}

# Проверка существования исходной директории
if [ ! -d "$BACKUP_SOURCE" ]; then
    log_message "ERROR: Исходная директория $BACKUP_SOURCE не существует"
    exit 1
fi

# Создание целевой директории, если не существует
mkdir -p "$BACKUP_DEST"
if [ $? -ne 0 ]; then
    log_message "ERROR: Не удалось создать директорию $BACKUP_DEST"
    exit 1
fi

log_message "START: Начало резервного копирования из $BACKUP_SOURCE в $BACKUP_DEST"

# Выполнение резервного копирования
rsync $RSYNC_OPTIONS "$BACKUP_SOURCE/" "$BACKUP_DEST/" 2>&1
RSYNC_EXIT_CODE=$?

if [ $RSYNC_EXIT_CODE -eq 0 ]; then
    log_message "SUCCESS: Резервное копирование завершено успешно"
    exit 0
else
    log_message "ERROR: Ошибка резервного копирования (код: $RSYNC_EXIT_CODE)"
    exit 1
fi
