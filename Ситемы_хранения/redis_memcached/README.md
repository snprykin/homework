# Домашнее задание "`Резервное копирование`" - `Прыкин Сергей`

### Задание 1

Составьте команду rsync, которая позволяет создавать зеркальную копию домашней директории пользователя в директорию /tmp/backup
Необходимо исключить из синхронизации все директории, начинающиеся с точки (скрытые)
Необходимо сделать так, чтобы rsync подсчитывал хэш-суммы для всех файлов, даже если их время модификации и размер идентичны в источнике и приемнике.
На проверку направить скриншот с командой и результатом ее выполнения

### Решение
```
rsync -avh --checksum --exclude='.*/' ~/ /tmp/backup/
```
![Задание 1_1](https://github.com/snprykin/homework/blob/main/%D0%9E%D1%82%D0%BA%D0%B0%D0%B7%D0%BE%D1%83%D1%81%D1%82%D0%BE%D0%B9%D1%87%D0%B8%D0%B2%D0%BE%D1%81%D1%82%D1%8C/backup/screenshots/1.jpg)

![Задание 1_2](https://github.com/snprykin/homework/blob/main/%D0%9E%D1%82%D0%BA%D0%B0%D0%B7%D0%BE%D1%83%D1%81%D1%82%D0%BE%D0%B9%D1%87%D0%B8%D0%B2%D0%BE%D1%81%D1%82%D1%8C/backup/screenshots/2.jpg)
---

### Задание 2

Написать скрипт и настроить задачу на регулярное резервное копирование домашней директории пользователя с помощью rsync и cron.
Резервная копия должна быть полностью зеркальной
Резервная копия должна создаваться раз в день, в системном логе должна появляться запись об успешном или неуспешном выполнении операции
Резервная копия размещается локально, в директории /tmp/backup
На проверку направить файл crontab и скриншот с результатом работы утилиты.

### Решение
``` 
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

```
Файл crontab: [crontab](https://github.com/snprykin/homework/blob/main/%D0%9E%D1%82%D0%BA%D0%B0%D0%B7%D0%BE%D1%83%D1%81%D1%82%D0%BE%D0%B9%D1%87%D0%B8%D0%B2%D0%BE%D1%81%D1%82%D1%8C/backup/screenshots/crontab)

![Задание 1_2](https://github.com/snprykin/homework/blob/main/%D0%9E%D1%82%D0%BA%D0%B0%D0%B7%D0%BE%D1%83%D1%81%D1%82%D0%BE%D0%B9%D1%87%D0%B8%D0%B2%D0%BE%D1%81%D1%82%D1%8C/backup/screenshots/3.jpg)

![Задание 1_2](https://github.com/snprykin/homework/blob/main/%D0%9E%D1%82%D0%BA%D0%B0%D0%B7%D0%BE%D1%83%D1%81%D1%82%D0%BE%D0%B9%D1%87%D0%B8%D0%B2%D0%BE%D1%81%D1%82%D1%8C/backup/screenshots/4.jpg)

![Задание 1_2](https://github.com/snprykin/homework/blob/main/%D0%9E%D1%82%D0%BA%D0%B0%D0%B7%D0%BE%D1%83%D1%81%D1%82%D0%BE%D0%B9%D1%87%D0%B8%D0%B2%D0%BE%D1%81%D1%82%D1%8C/backup/screenshots/5.jpg)