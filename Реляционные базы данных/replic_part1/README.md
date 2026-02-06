# Домашнее задание к занятию «Работа с данными (DDL/DML)» - `Прыкин Сергей`

## Задание 1

1. Master-Slave (Ведущий-ведомый) - Классическая репликация
	Основная идея: Один узел (master) принимает операции записи и чтения, а один или несколько узлов (slave) реплицируют данные с мастера для операций чтения.
	Как это работает:
	Master (ведущий): Обрабатывает все операции записи (INSERT, UPDATE, DELETE). Все изменения записываются в его бинарный лог (binlog, WAL).
	Slave (ведомый): Подключается к мастеру, читает его бинарный лог и применяет изменения к своей копии данных (обычно асинхронно). Обрабатывает только операции чтения (SELECT).

	Плюсы:
	Масштабирование чтения: Можно добавить много слейвов для распределения нагрузки на чтение.
	Резервное копирование и аналитика: Слейвы можно использовать для бэкапов или тяжелых аналитических запросов без нагрузки на мастер.
	Повышенная доступность: При падении мастера один из слейвов можно назначить новым мастером (с помощью дополнительных инструментов).
	Простота: Концептуально и технически проще, чем master-master.

	Минусы:
	Единая точка отказа (SPOF): Мастер — единственная точка для записи. Если он упадет, запись будет невозможна до восстановления.
	Задержка репликации (Replication Lag): Слейвы могут отставать от мастера, что приводит к чтению устаревших данных.
	Не масштабирует запись: Все операции записи идут через один узел.
	Идеальный случай: Приложения, где чтение значительно превышает запись (например, блоги, новостные сайты, каталоги товаров).

2. Master-Master (или Multi-Master) - Двунаправленная репликация
	Основная идея: Два или более узла могут принимать операции записи и чтения. Изменения, сделанные на любом из узлов, реплицируются на все остальные.
	Как это работает:
	Каждый узел является одновременно и мастером (для своих клиентов) и слейвом (получает изменения от других мастеров).
	Требуются механизмы для разрешения конфликтов, если на разных узлах одновременно изменили одни и те же данные.

	Плюсы:
	Отказоустойчивость записи: Если один мастер падает, запись может продолжиться на других. Нет единой точки отказа для операций записи.
	Географическое распределение: Мастера можно разместить в разных регионах для записи данных ближе к пользователям.
	Балансировка нагрузки записи: Теоретически можно распределять запись между узлами (на практике сложно из-за конфликтов).

	Минусы:
	Сложность: Очень сложна в настройке и поддержке.
	Конфликты репликации: Самый большой недостаток. Если два пользователя изменят одну и ту же строку на разных мастерах одновременно, возникнет конфликт. Его разрешение может быть нетривиальным (например, "последняя запись побеждает", что ведет к потере данных).
	Риск расходящихся данных: При некорректной обработке конфликтов данные на узлах могут разойтись.
	Часто не дает выигрыша в производительности: Накладные расходы на разрешение конфликтов и двустороннюю репликацию могут "съесть" выгоду.

![Ответ](https://github.com/snprykin/homework/blob/main/%D0%A0%D0%B5%D0%BB%D1%8F%D1%86%D0%B8%D0%BE%D0%BD%D0%BD%D1%8B%D0%B5%20%D0%B1%D0%B0%D0%B7%D1%8B%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85/sql/screenshots/1.png)

### 1.2

CREATE USER 'sys_temp'@'localhost' IDENTIFIED BY 'Pass123';

### 1.3

![Ответ](https://github.com/snprykin/homework/blob/main/%D0%A0%D0%B5%D0%BB%D1%8F%D1%86%D0%B8%D0%BE%D0%BD%D0%BD%D1%8B%D0%B5%20%D0%B1%D0%B0%D0%B7%D1%8B%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85/sql/screenshots/2.png)

### 1.4

GRANT ALL PRIVILEGES ON *.* TO 'sys_temp'@'%' WITH GRANT OPTION;  
FLUSH PRIVILEGES;

### 1.5

![Ответ](https://github.com/snprykin/homework/blob/main/%D0%A0%D0%B5%D0%BB%D1%8F%D1%86%D0%B8%D0%BE%D0%BD%D0%BD%D1%8B%D0%B5%20%D0%B1%D0%B0%D0%B7%D1%8B%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85/sql/screenshots/3.png)

### 1.6

docker exec -it mysql8 mysql -u sys_test -p  

![Ответ](https://github.com/snprykin/homework/blob/main/%D0%A0%D0%B5%D0%BB%D1%8F%D1%86%D0%B8%D0%BE%D0%BD%D0%BD%D1%8B%D0%B5%20%D0%B1%D0%B0%D0%B7%D1%8B%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85/sql/screenshots/4.png)  

ALTER USER 'sys_test'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';      
ERROR 1396 (HY000): Operation ALTER USER failed for 'sys_test'@'localhost'  
CREATE USER 'sys_test'@'localhost' IDENTIFIED BY 'password';  

![Ответ](https://github.com/snprykin/homework/blob/main/%D0%A0%D0%B5%D0%BB%D1%8F%D1%86%D0%B8%D0%BE%D0%BD%D0%BD%D1%8B%D0%B5%20%D0%B1%D0%B0%D0%B7%D1%8B%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85/sql/screenshots/5.png)

### 1.7

docker cp sakila-schema.sql mysql8:/tmp/    
docker cp sakila-data.sql mysql8:/tmp/    
SOURCE /tmp/sakila-schema.sql;    
mysql> SOURCE /tmp/sakila-data.sql;  

![Ответ](https://github.com/snprykin/homework/blob/main/%D0%A0%D0%B5%D0%BB%D1%8F%D1%86%D0%B8%D0%BE%D0%BD%D0%BD%D1%8B%D0%B5%20%D0%B1%D0%B0%D0%B7%D1%8B%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85/sql/screenshots/6.png)

### 1.8

SHOW TABLES;  

![Ответ](https://github.com/snprykin/homework/blob/main/%D0%A0%D0%B5%D0%BB%D1%8F%D1%86%D0%B8%D0%BE%D0%BD%D0%BD%D1%8B%D0%B5%20%D0%B1%D0%B0%D0%B7%D1%8B%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85/sql/screenshots/7.png)

---

## Задание 2

SELECT 
    TABLE_NAME AS 'Таблица',
    GROUP_CONCAT(COLUMN_NAME ORDER BY ORDINAL_POSITION) AS 'Первичный ключ'
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'sakila' 
    AND CONSTRAINT_NAME = 'PRIMARY'
GROUP BY TABLE_NAME
ORDER BY TABLE_NAME;  

|Table	        | Primary_Key       |
|:--------------|:------------------|
|actor	        |actor_id           |
|address	    |address_id         |
|category	    |category_id        |
|city	        |city_id            |
|country	    |country_id         |
|customer	    |customer_id        |
|film	        |film_id            |
|film_actor	    |actor_id film_id   |
|film_category	|film_id category_id|
|film_text	    |film_id            |
|inventory	    |inventory_id       |
|language	    |language_id        |
|payment	    |payment_id         |
|rental	        |rental_id          |
|staff	        |staff_id           |
|store	        |store_id           |  

![Ответ](https://github.com/snprykin/homework/blob/main/%D0%A0%D0%B5%D0%BB%D1%8F%D1%86%D0%B8%D0%BE%D0%BD%D0%BD%D1%8B%D0%B5%20%D0%B1%D0%B0%D0%B7%D1%8B%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85/sql/screenshots/8.png)

---

## Задание 3

REVOKE INSERT, UPDATE, DELETE ON sakila.* FROM 'sys_temp'@'%';  
FLUSH PRIVILEGES;  

![Ответ](https://github.com/snprykin/homework/blob/main/%D0%A0%D0%B5%D0%BB%D1%8F%D1%86%D0%B8%D0%BE%D0%BD%D0%BD%D1%8B%D0%B5%20%D0%B1%D0%B0%D0%B7%D1%8B%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85/sql/screenshots/9.png)


