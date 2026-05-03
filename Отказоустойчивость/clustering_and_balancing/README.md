# Домашнее задание "`Кластеризация и балансировка нагрузки`" - `Прыкин Сергей`

### Задание 1

Запустите два simple python сервера на своей виртуальной машине на разных портах
Установите и настройте HAProxy, воспользуйтесь материалами к лекции по ссылке
Настройте балансировку Round-robin на 4 уровне.
На проверку направьте конфигурационный файл haproxy, скриншоты, где видно перенаправление запросов на разные серверы при обращении к HAProxy.

### Решение

```
global
    log         127.0.0.1 local2

    chroot      /var/lib/haproxy
    pidfile     /var/run/haproxy.pid
    maxconn     4000
    user        haproxy
    group       haproxy
    daemon

    # turn on stats unix socket
    stats socket /var/lib/haproxy/stats

    # utilize system-wide crypto-policies
    ssl-default-bind-ciphers PROFILE=SYSTEM
    ssl-default-server-ciphers PROFILE=SYSTEM

defaults
    mode                    http
    log                     global
    option                  httplog
    option                  dontlognull
    option http-server-close
    option forwardfor       except 127.0.0.0/8
    option                  redispatch
    retries                 3
    timeout http-request    10s
    timeout queue           1m
    timeout connect         10s
    timeout client          1m
    timeout server          1m
    timeout http-keep-alive 10s
    timeout check           10s
    maxconn                 3000

frontend haproxy 
    bind *:8088 
    stats uri /haproxy?stats 
    default_backend webservers 

backend webservers    
    balance roundrobin    
    server s1 127.0.0.1:7777 check    
    server s2 127.0.0.1:8888 check

listen stats
    bind *:888
    stats enable
    stats uri /
    stats refresh 5s
    stats realm Haproxy\ Stats
listen web_tcp
    bind *:1325
    mode tcp
    balance roundrobin
    option tcp-check
    server s1 127.0.0.1:7777 check inter 3s
    server s2 127.0.0.1:8888 check inter 3s
```

![Задание 1_1](https://github.com/snprykin/homework/blob/main/%D0%9E%D1%82%D0%BA%D0%B0%D0%B7%D0%BE%D1%83%D1%81%D1%82%D0%BE%D0%B9%D1%87%D0%B8%D0%B2%D0%BE%D1%81%D1%82%D1%8C/clustering_and_balancing/screenshots/1.jpg)

![Задание 1_2](https://github.com/snprykin/homework/blob/main/%D0%9E%D1%82%D0%BA%D0%B0%D0%B7%D0%BE%D1%83%D1%81%D1%82%D0%BE%D0%B9%D1%87%D0%B8%D0%B2%D0%BE%D1%81%D1%82%D1%8C/clustering_and_balancing/screenshots/2.jpg)
---

### Задание 2

Запустите три simple python сервера на своей виртуальной машине на разных портах
Настройте балансировку Weighted Round Robin на 7 уровне, чтобы первый сервер имел вес 2, второй - 3, а третий - 4
HAproxy должен балансировать только тот http-трафик, который адресован домену example.local
На проверку направьте конфигурационный файл haproxy, скриншоты, где видно перенаправление запросов на разные серверы при обращении к HAProxy
c использованием домена example.local и без него.

### Решение

```
global
   
    log         127.0.0.1 local2

    chroot      /var/lib/haproxy
    pidfile     /var/run/haproxy.pid
    maxconn     4000
    user        haproxy
    group       haproxy
    daemon

    
    stats socket /var/lib/haproxy/stats

    
    ssl-default-bind-ciphers PROFILE=SYSTEM
    ssl-default-server-ciphers PROFILE=SYSTEM


defaults
    mode                    http
    log                     global
    option                  httplog
    option                  dontlognull
    option http-server-close
    option forwardfor       except 127.0.0.0/8
    option                  redispatch
    retries                 3
    timeout http-request    10s
    timeout queue           1m
    timeout connect         10s
    timeout client          1m
    timeout server          1m
    timeout http-keep-alive 10s
    timeout check           10s
    maxconn                 3000

frontend haproxy      
    mode http
    bind *:8088   
    stats uri /haproxy?stats    
    #default_backend webservers  
    acl ACL_example.local hdr(host) -i example.local
    use_backend webservers if ACL_example.local

backend webservers    
    mode http
    balance roundrobin    
    option httpchk
    http-check send meth GET uri /index.html
    server s1 127.0.0.1:7777 check weight 2    
    server s2 127.0.0.1:8888 check weight 3
    server s3 127.0.0.1:9999 check weight 4

listen stats
    bind *:888
    mode http
    stats enable
    stats uri /
    stats refresh 5s
    stats realm Haproxy\ Stats
```

![Задание 1_1](https://github.com/snprykin/homework/blob/main/%D0%9E%D1%82%D0%BA%D0%B0%D0%B7%D0%BE%D1%83%D1%81%D1%82%D0%BE%D0%B9%D1%87%D0%B8%D0%B2%D0%BE%D1%81%D1%82%D1%8C/clustering_and_balancing/screenshots/3.jpg)

![Задание 1_1](https://github.com/snprykin/homework/blob/main/%D0%9E%D1%82%D0%BA%D0%B0%D0%B7%D0%BE%D1%83%D1%81%D1%82%D0%BE%D0%B9%D1%87%D0%B8%D0%B2%D0%BE%D1%81%D1%82%D1%8C/clustering_and_balancing/screenshots/4.jpg)