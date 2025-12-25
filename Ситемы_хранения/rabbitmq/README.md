# Домашнее задание «Очереди RabbitMQ» - `Прыкин Сергей`

## Задание 1
### Установка RabbitMQ
![Ответ](https://github.com/snprykin/homework/blob/main/%D0%A1%D0%B8%D1%82%D0%B5%D0%BC%D1%8B_%D1%85%D1%80%D0%B0%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F/redis_memcached/screenshots/1.jpg)

---

## Задание 2
### Отправка и получение сообщений
![Ответ](https://github.com/snprykin/homework/blob/main/%D0%A1%D0%B8%D1%82%D0%B5%D0%BC%D1%8B_%D1%85%D1%80%D0%B0%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F/redis_memcached/screenshots/1.jpg)
![Ответ](https://github.com/snprykin/homework/blob/main/%D0%A1%D0%B8%D1%82%D0%B5%D0%BC%D1%8B_%D1%85%D1%80%D0%B0%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F/redis_memcached/screenshots/1.jpg)

---

## Задание 3
### Подготовка HA кластера
![Ответ](https://github.com/snprykin/homework/blob/main/%D0%A1%D0%B8%D1%82%D0%B5%D0%BC%D1%8B_%D1%85%D1%80%D0%B0%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F/redis_memcached/screenshots/2.jpg)
![Ответ](https://github.com/snprykin/homework/blob/main/%D0%A1%D0%B8%D1%82%D0%B5%D0%BC%D1%8B_%D1%85%D1%80%D0%B0%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F/redis_memcached/screenshots/1.jpg)
![Ответ](https://github.com/snprykin/homework/blob/main/%D0%A1%D0%B8%D1%82%D0%B5%D0%BC%D1%8B_%D1%85%D1%80%D0%B0%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F/redis_memcached/screenshots/1.jpg)
![Ответ](https://github.com/snprykin/homework/blob/main/%D0%A1%D0%B8%D1%82%D0%B5%D0%BC%D1%8B_%D1%85%D1%80%D0%B0%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F/redis_memcached/screenshots/1.jpg)
![Ответ](https://github.com/snprykin/homework/blob/main/%D0%A1%D0%B8%D1%82%D0%B5%D0%BC%D1%8B_%D1%85%D1%80%D0%B0%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F/redis_memcached/screenshots/1.jpg)
![Ответ](https://github.com/snprykin/homework/blob/main/%D0%A1%D0%B8%D1%82%D0%B5%D0%BC%D1%8B_%D1%85%D1%80%D0%B0%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F/redis_memcached/screenshots/1.jpg)

---

## Задание 4
### Ansible playbook
#### Настройка инвентаризации:
Отредактируйте файл inventory.yml под ваши серверы
#### Шифрование паролей (рекомендуется):
Создайте зашифрованный файл переменных
ansible-vault create group_vars/rabbitmq_nodes/vault.yml
#### Запуск playbook:
Основная установка и настройка
ansible-playbook -i inventory.yml rabbitmq-cluster.yml

Проверка кластера
ansible-playbook -i inventory.yml check-cluster.yml
#### Проверка через веб-интерфейс:
Откройте в браузере: http://<node-ip>:15672
Логин: admin
Пароль: YourSecurePassword123

![Ответ](https://github.com/snprykin/homework/blob/main/%D0%A1%D0%B8%D1%82%D0%B5%D0%BC%D1%8B_%D1%85%D1%80%D0%B0%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F/redis_memcached/screenshots/3.jpg)


