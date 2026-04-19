# Домашнее задание "Оркестрация группой Docker контейнеров на примере Docker Compose" - `Прыкин Сергей`

### Задание 1

Сценарий выполнения задачи:

Установите docker и docker compose plugin на свою linux рабочую станцию или ВМ.
Если dockerhub недоступен создайте файл /etc/docker/daemon.json с содержимым: {"registry-mirrors": ["https://mirror.gcr.io", "https://daocloud.io", "https://c.163.com/", "https://registry.docker-cn.com"]}
Зарегистрируйтесь и создайте публичный репозиторий с именем "custom-nginx" на https://hub.docker.com (ТОЛЬКО ЕСЛИ У ВАС ЕСТЬ ДОСТУП);
скачайте образ nginx:1.29.0;
Создайте Dockerfile и реализуйте в нем замену дефолтной индекс-страницы(/usr/share/nginx/html/index.html), на файл index.html с содержимым:
```
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I will be DevOps Engineer!</h1>
</body>
</html>
```
Соберите и отправьте созданный образ в свой dockerhub-репозитории c tag 1.0.0 (ТОЛЬКО ЕСЛИ ЕСТЬ ДОСТУП).
Предоставьте ответ в виде ссылки на https://hub.docker.com/<username_repo>/custom-nginx/general .

### Решение

Dockerfile
```
FROM nginx:1.29.0

COPY index.html /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```
Ссылка на docker hub  
https://hub.docker.com/repository/docker/snprykin/custom-nginx/general  

![1](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/1.png)

![2](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/2.png)

![3](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/3.png)
---

### Задание 2

1. Запустите ваш образ custom-nginx:1.0.0 командой docker run в соответвии с требованиями:
имя контейнера "ФИО-custom-nginx-t2"
контейнер работает в фоне
контейнер опубликован на порту хост системы 127.0.0.1:8080
2. Не удаляя, переименуйте контейнер в "custom-nginx-t2"
3. Выполните команду date +"%d-%m-%Y %T.%N %Z" ; sleep 0.150 ; docker ps ; ss -tlpn | grep 127.0.0.1:8080  ; docker logs custom-nginx-t2 -n1 ; docker exec -it custom-nginx-t2 base64 /usr/share/nginx/html/index.html
4. Убедитесь с помощью curl или веб браузера, что индекс-страница доступна.

### Решение

![4](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/4.png)

![5](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/5.png)

![6](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/6.png)

![7](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/7.png)
---

### Задание 3

1. Воспользуйтесь docker help или google, чтобы узнать как подключиться к стандартному потоку ввода/вывода/ошибок контейнера "custom-nginx-t2".
2. Подключитесь к контейнеру и нажмите комбинацию Ctrl-C.
3. Выполните docker ps -a и объясните своими словами почему контейнер остановился.
4. Перезапустите контейнер
5. Зайдите в интерактивный терминал контейнера "custom-nginx-t2" с оболочкой bash.
6. Установите любимый текстовый редактор(vim, nano итд) с помощью apt-get.
7. Отредактируйте файл "/etc/nginx/conf.d/default.conf", заменив порт "listen 80" на "listen 81".
8. Запомните(!) и выполните команду nginx -s reload, а затем внутри контейнера curl http://127.0.0.1:80 ; curl http://127.0.0.1:81.
9. Выйдите из контейнера, набрав в консоли exit или Ctrl-D.
10. Проверьте вывод команд: ss -tlpn | grep 127.0.0.1:8080 , docker port custom-nginx-t2, curl http://127.0.0.1:8080. Кратко объясните суть возникшей проблемы.
11. Это дополнительное, необязательное задание. Попробуйте самостоятельно исправить конфигурацию контейнера, используя доступные источники в интернете. Не изменяйте конфигурацию nginx и не удаляйте контейнер. Останавливать контейнер можно. пример источника
12. Удалите запущенный контейнер "custom-nginx-t2", не останавливая его.(воспользуйтесь --help или google)

### Решение
При подключении через docker attach и нажатии Ctrl+C сигнал прерывания передается главному  
процессу внутри контейнера (nginx). Nginx, получив сигнал SIGINT,  
завершает свою работу, что приводит к остановке контейнера,  
так как контейнер жив пока жив его главный процесс (PID 1)

![8](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/8.png)
![9](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/9.png)
![10](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/10.png)
![11](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/11.png)
![12](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/12.png)

Контейнер опубликован с пробросом порта 127.0.0.1:8080:80.  
После изменения в конфигурации nginx порта с 80 на 81, приложение внутри контейнера больше не слушает порт 80.  
Docker продолжает пробрасывать трафик с хоста:8080 на контейнер:80, но на порту 80 внутри контейнера ничего не слушает,  
поэтому соединение не устанавливается.

![13](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/13.png)
![14](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/14.png)

Изменить проброс порта без пересоздания контейнера невозможно.  
Но можно перенаправить трафик внутри контейнера:
```
# Войти в контейнер
docker exec -it custom-nginx-t2 bash

# Установить iptables
apt-get update && apt-get install -y iptables

# Перенаправить трафик с порта 80 на 81
iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 81
```
![15](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/15.png)
![16](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/16.png)

Или вернуть конфиг обратно:
```
docker exec -it custom-nginx-t2 bash
sed -i 's/listen 81;/listen 80;/' /etc/nginx/conf.d/default.conf
nginx -s reload
```
Удаление запущеного контейнера
```
docker rm -f custom-nginx-t2
```
Флаг -f (force) останавливает и удаляет запущенный контейнер без предварительной остановки.

![17](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/17.png)

---

### Задание 4

Запустите первый контейнер из образа centos c любым тегом в фоновом режиме,  
подключив папку текущий рабочий каталог $(pwd) на хостовой машине в /data контейнера, используя ключ -v.  
Запустите второй контейнер из образа debian в фоновом режиме,  
подключив текущий рабочий каталог $(pwd) в /data контейнера.  
Подключитесь к первому контейнеру с помощью docker exec и создайте текстовый файл любого содержания в /data.  
Добавьте ещё один файл в текущий каталог $(pwd) на хостовой машине.  
Подключитесь во второй контейнер и отобразите листинг и содержание файлов в /data контейнера.  

### Решение

Запуск первого контейнера из образа centos
```
docker run -d --name centos-container -v $(pwd):/data centos:centos7 tail -f /dev/null
```
Запуск второго контейнера из образа debian
```
docker run -d --name debian-container -v $(pwd):/data debian:latest tail -f /dev/null
```
Подключение к первому контейнеру и создание файла
```
# Подключаемся к centos контейнеру
docker exec -it centos-container bash
# Внутри контейнера создаем файл в /data
echo 'Hello from CentOS container!' > /data/centos-file.txt
# Выходим из контейнера
exit
```
Добавление файла на хостовой машине
```
# Создаем файл в текущей директории на хосте
echo 'This file was created on the host machine' > host-file.txt
```
Подключение ко второму контейнеру и просмотр файлов
```
# Подключаемся к debian контейнеру
docker exec -it debian-container bash
# Внутри debian контейнера смотрим листинг /data
ls -la /data
# Смотрим содержимое всех файлов
cat /data/centos-file.txt
cat /data/host-file.txt
# Или все файлы сразу
cat /data/*
# Выходим из контейнера
exit
```
![18](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/18.png)
![19](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/19.png)

Так как оба контейнера используют одну и ту же папку $(pwd) на хосте, все изменения,  
сделанные в одном контейнере, будут видны в другом контейнере и на хостовой машине.  
Это демонстрирует работу общих volume между контейнерами.

---


### Задание 5

1. Создайте отдельную директорию(например /tmp/netology/docker/task5) и 2 файла внутри него. "compose.yaml" с содержимым:
```
version: "3"
services:
  portainer:
    network_mode: host
    image: portainer/portainer-ce:latest
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
"docker-compose.yaml" с содержимым:

version: "3"
services:
  registry:
    image: registry:2

    ports:
    - "5000:5000"
```
И выполните команду "docker compose up -d". Какой из файлов был запущен и почему? (подсказка: https://docs.docker.com/compose/compose-application-model/#the-compose-file )  
2. Отредактируйте файл compose.yaml так, чтобы были запущенны оба файла. (подсказка: https://docs.docker.com/compose/compose-file/14-include/)  
3. Выполните в консоли вашей хостовой ОС необходимые команды чтобы залить образ custom-nginx как custom-nginx:latest в запущенное вами, локальное registry. Дополнительная документация: https://distribution.github.io/distribution/about/deploying/  
4. Откройте страницу "https://127.0.0.1:9000" и произведите начальную настройку portainer.(логин и пароль адмнистратора)  
5. Откройте страницу "http://127.0.0.1:9000/#!/home", выберите ваше local окружение. Перейдите на вкладку "stacks" и в "web editor" задеплойте следующий компоуз:
```
version: '3'

services:
  nginx:
    image: 127.0.0.1:5000/custom-nginx
    ports:
      - "9090:80"
```
6. Перейдите на страницу "http://127.0.0.1:9000/#!/2/docker/containers", выберите контейнер с nginx и нажмите на кнопку "inspect". В представлении <> Tree разверните поле "Config" и сделайте скриншот от поля "AppArmorProfile" до "Driver".
7. Удалите любой из манифестов компоуза(например compose.yaml). Выполните команду "docker compose up -d". Прочитайте warning, объясните суть предупреждения и выполните предложенное действие. Погасите compose-проект ОДНОЙ(обязательно!!) командой.

### Решение
Создание директории и файлов
```
# Создаем директорию
mkdir  task5
cd task5
# Создаем compose.yaml
cat > compose.yaml << 'EOF'
version: "3"
services:
  portainer:
    network_mode: host
    image: portainer/portainer-ce:latest
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
EOF
# Создаем docker-compose.yaml
cat > docker-compose.yaml << 'EOF'
version: "3"
services:
  registry:
    image: registry:2
    ports:
      - "5000:5000"
EOF
```
Какой файл был запущен и почему?
```
docker compose up -d
```
Будет запущен файл compose.yaml.  
Docker Compose ищет файлы в следующем порядке приоритета:  
compose.yaml  
compose.yml  
docker-compose.yaml  
docker-compose.yml  

Поскольку compose.yaml существует и имеет более высокий приоритет, он будет использован, а docker-compose.yaml игнорируется.
![20](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/20.png)

Редактируем compose.yaml для запуска обоих сервисов
```
cat > compose.yaml << 'EOF'
version: "3"
include:
  - docker-compose.yaml

services:
  portainer:
    network_mode: host
    image: portainer/portainer-ce:latest
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
EOF
```
Теперь выполняем запуск:
```
docker compose up -d
```
Будут запущены оба сервиса:
portainer (из compose.yaml)
registry (из включенного docker-compose.yaml)

![21](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/21.png)

Заливаем образ custom-nginx в локальное registry
```
# Проверяем, что registry работает
curl http://localhost:5000/v2/_catalog
# Смотрим список образов
docker images | grep custom-nginx
# Тегируем образ для локального registry
docker tag snprykin/custom-nginx:1.0.0 localhost:5000/custom-nginx:latest
# Или если нет образа, создаем его
docker pull nginx:latest
docker tag nginx:latest localhost:5000/custom-nginx:latest
# Пушим образ в локальный registry
docker push localhost:5000/custom-nginx:latest
# Проверяем, что образ появился в registry
curl http://localhost:5000/v2/custom-nginx/tags/list
```

![22](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/22.png)
![23](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/23.png)

Настройка Portainer  
Откройте в браузере: http://127.0.0.1:9000  
При первом входе:  
Создайте пользователя-администратора (логин и пароль)  

![24](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/24.png)
![25](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/25.png)

Деплой стека через Portainer

![26](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/26.png)

```
version: '3'
services:
  nginx:
    image: 127.0.0.1:5000/custom-nginx
    ports:
      - "9090:80"
```
![27](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/27.png)
![28](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/28.png)

Скриншот inspect

![29](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/29.png)
![30](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/30.png)
```
# Удаляем compose.yaml
rm compose.yaml
# Выполняем docker compose up -d
docker compose up -d
```
![31](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/31.png)

Был найден "осиротевший" контейнер task5-portainer-1,  
который принадлежал этому проекту, но теперь его нет в текущем файле docker-compose.yaml  
Docker Compose сообщает, что этот контейнер больше не управляется текущей конфигурацией.  

Предложенное действие:
```
# Очищаем осиротевшие контейнеры и запускаем проект заново
docker compose up -d --remove-orphans
```
![32](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/32.png)

Гасим compose-проект ОДНОЙ командой
```
docker compose down
```
Эта команда останавливает и удаляет все контейнеры, сети и другие ресурсы, созданные проектом.
![33](https://github.com/snprykin/homework/blob/main/Виртуализация/docker_compose/screenshots/33.png)
