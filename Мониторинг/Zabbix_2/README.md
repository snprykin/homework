# Домашнее задание "`Система мониторинга Zabbix`" - `Прыкин Сергей`

### Задание 1

**Установите Zabbix Server с веб-интерфейсом.**

### Процесс выполнения
1. Выполняя ДЗ, сверяйтесь с процессом отражённым в записи лекции.
2. Установите PostgreSQL. Для установки достаточна та версия, что есть в системном репозитороии  Debian 11.
Пользуясь конфигуратором команд с официального сайта, составьте набор команд для установки последней версии Zabbix с поддержкой PostgreSQL и Apache.
3. Выполните все необходимые команды для установки Zabbix Server и Zabbix Web Server.

### Требования к результатам

1. Прикрепите в файл README.md скриншот авторизации в админке.

![Админ панель Zabbix](https://github.com/snprykin/gitlab-hw/blob/main/screenshots/1.jpg)`

2. Приложите в файл README.md текст использованных команд в GitHub.

```
sudo apt install postgresql
wget https://repo.zabbix.com/zabbix/7.4/release/ubuntu/pool/main/z/zabbix-release/zabbix-release_>
sudo dpkg -i zabbix-release_latest_7.4+ubuntu24.04_all.deb
sudo apt update 
sudo apt install zabbix-server-pgsql zabbix-frontend-php php8.3-pgsql zabbix-apache-conf zabbix-s>
systemctl status zabbix-server.service 
sudo -u postgres createuser --pwprompt zabbix
sudo -u postgres createdb -O zabbix zabbix
zcat /usr/share/zabbix/sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix
sudo sed -i 's/# DBPassword=/DBPassword=12345678/g' /etc/zabbix/zabbix_server.conf
sudo systemctl restart zabbix-server apache2
sudo systemctl enable zabbix-server apache2

```

---

### Задание 2

**Установите Zabbix Agent на два хоста.**

### Процесс выполнения
1. Выполняя ДЗ, сверяйтесь с процессом отражённым в записи лекции.
2. Установите Zabbix Agent на 2 вирт.машины, одной из них может быть ваш Zabbix Server.
3. Добавьте Zabbix Server в список разрешенных серверов ваших Zabbix Agentов.
4. Добавьте Zabbix Agentов в раздел Configuration > Hosts вашего Zabbix Servera.
5. Проверьте, что в разделе Latest Data начали появляться данные с добавленных агентов.

### Требования к результатам
1. Приложите в файл README.md скриншот раздела Configuration > Hosts, где видно, что агенты подключены к серверу

![Hosts](https://github.com/snprykin/gitlab-hw/blob/main/screenshots/2.jpg)`

2. Приложите в файл README.md скриншот лога zabbix agent, где видно, что он работает с сервером

![Log_1](https://github.com/snprykin/gitlab-hw/blob/main/screenshots/3.jpg)`

3. Приложите в файл README.md скриншот раздела Monitoring > Latest data для обоих хостов, где видны поступающие от агентов данные.

![Latest data](https://github.com/snprykin/gitlab-hw/blob/main/screenshots/4.jpg)`

4. Приложите в файл README.md текст использованных команд в GitHub


```

sudo -i
apt update 
apt upgrade 
wget https://repo.zabbix.com/zabbix/7.4/release/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest_7.4+ubuntu24.04_all.deb
dpkg -i zabbix-release_latest_7.4+ubuntu24.04_all.deb
apt update
apt install zabbix-agent2
sed -i 's/Server=127.0.0.1/Server=158.160.178.98/g' /etc/zabbix/zabbix_agent2.conf
systemctl restart zabbix-agent2.service 
systemctl enable zabbix-agent2.service 

```



