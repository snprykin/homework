# Домашнее задание "Работа с roles" - `Прыкин Сергей`

## Ссылки на репозитории

| Компонент | Ссылка |
|-----------|--------|
| **Vector role** | [github.com/snprykin/vector-role](https://github.com/snprykin/vector-role) |
| **Lighthouse role** | [github.com/snprykin/lighthouse-role](https://github.com/snprykin/lighthouse-role) |
| **Playbook** | [github.com/snprykin/playbook](https://github.com/snprykin/playbook) |

## Выполнение задания

### 1. Подготовка
- Созданы публичные репозитории: `vector-role`, `lighthouse-role`, `playbook`
- Публичный SSH-ключ добавлен в GitHub

### 2. Vector Role (v1.0.0)
Роль создана через `ansible-galaxy role init vector-role`:
- **defaults/main.yml** — настраиваемые параметры: версия Vector, ClickHouse хост/порт/БД/таблица
- **vars/main.yml** — вычисляемые: URL пакета, пути к конфигам
- **templates/vector.yml.j2** — Jinja2 шаблон с source (nginx_access) и sink (clickhouse)
- **tasks/main.yml** — 8 задач: зависимости → скачивание .deb → установка → деплой конфига → запуск systemd
- **handlers/main.yml** — перезапуск Vector при изменении конфига
- **README.md** — документированы все параметры

### 3. Lighthouse Role (v1.0.0)
Роль создана через `ansible-galaxy role init lighthouse-role`:
- Устанавливает зависимости: git, nginx, nodejs, npm
- Клонирует `VKCOM/lighthouse` и собирает через npm
- **templates/lighthouse.conf.j2** — Nginx конфиг с gzip и безопасностью
- **tasks/main.yml** — 9 задач: зависимости → клонирование → сборка → Nginx конфиг → активация сайта
- **handlers/main.yml** — перезапуск Nginx
- **README.md** — документированы параметры

### 4. Playbook
- **requirements.yml** — 3 роли:
  - `AlexeySetevoi/ansible-clickhouse` (v1.13) — внешняя
  - `snprykin/vector-role` (v1.0.0) — своя
  - `snprykin/lighthouse-role` (v1.0.0) — своя
- **playbook.yml** — использует `include_role`, создаёт БД `logs` в ClickHouse
- **group_vars/all.yml** — общие переменные для всех ролей
- **ansible.cfg** — настройки: отключение проверки SSH-ключей, пути к ролям

### 5. Проверка
```bash
$ ansible-galaxy install -r requirements.yml --force
- clickhouse (1.13) was installed successfully
- vector-role (v1.0.0) was installed successfully
- lighthouse-role (v1.0.0) was installed successfully

$ ansible-playbook playbook.yml --syntax-check
playbook: playbook.yml

