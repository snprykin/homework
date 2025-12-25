# Домашнее задание к занятию «Работа с данными (DDL/DML)» - `Прыкин Сергей`

## Задание 1
### 1.1
![Ответ](https://github.com/snprykin/homework/blob/main/%D0%A1%D0%B8%D1%82%D0%B5%D0%BC%D1%8B_%D1%85%D1%80%D0%B0%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F/rabbitmq/screenshots/1.png)
### 1.2
CREATE USER 'sys_temp'@'localhost' IDENTIFIED BY 'Pass123';

### 1.3
![Ответ](https://github.com/snprykin/homework/blob/main/%D0%A1%D0%B8%D1%82%D0%B5%D0%BC%D1%8B_%D1%85%D1%80%D0%B0%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F/rabbitmq/screenshots/2.png)
### 1.4
GRANT ALL PRIVILEGES ON *.* TO 'sys_temp'@'%' WITH GRANT OPTION;  
FLUSH PRIVILEGES;
### 1.5
![Ответ](https://github.com/snprykin/homework/blob/main/%D0%A1%D0%B8%D1%82%D0%B5%D0%BC%D1%8B_%D1%85%D1%80%D0%B0%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F/rabbitmq/screenshots/3.png)
### 1.6
docker exec -it mysql8 mysql -u sys_test -p  
![Ответ](https://github.com/snprykin/homework/blob/main/%D0%A1%D0%B8%D1%82%D0%B5%D0%BC%D1%8B_%D1%85%D1%80%D0%B0%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F/rabbitmq/screenshots/4.png)
ALTER USER 'sys_test'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';    
ERROR 1396 (HY000): Operation ALTER USER failed for 'sys_test'@'localhost'  
CREATE USER 'sys_test'@'localhost' IDENTIFIED BY 'password';  
![Ответ](https://github.com/snprykin/homework/blob/main/%D0%A1%D0%B8%D1%82%D0%B5%D0%BC%D1%8B_%D1%85%D1%80%D0%B0%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F/rabbitmq/screenshots/5.png)
### 1.7
docker cp sakila-schema.sql mysql8:/tmp/  
docker cp sakila-data.sql mysql8:/tmp/  
SOURCE /tmp/sakila-schema.sql;  
mysql> SOURCE /tmp/sakila-data.sql;

![Ответ](https://github.com/snprykin/homework/blob/main/%D0%A1%D0%B8%D1%82%D0%B5%D0%BC%D1%8B_%D1%85%D1%80%D0%B0%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F/rabbitmq/screenshots/6.png)
### 1.8
SHOW TABLES;
![Ответ](https://github.com/snprykin/homework/blob/main/%D0%A1%D0%B8%D1%82%D0%B5%D0%BC%D1%8B_%D1%85%D1%80%D0%B0%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F/rabbitmq/screenshots/7.png)

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
![Ответ](https://github.com/snprykin/homework/blob/main/%D0%A1%D0%B8%D1%82%D0%B5%D0%BC%D1%8B_%D1%85%D1%80%D0%B0%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F/rabbitmq/screenshots/7.png)
---

## Задание 3
REVOKE INSERT, UPDATE, DELETE ON sakila.* FROM 'sys_temp'@'%';  
FLUSH PRIVILEGES;  
![Ответ](https://github.com/snprykin/homework/blob/main/%D0%A1%D0%B8%D1%82%D0%B5%D0%BC%D1%8B_%D1%85%D1%80%D0%B0%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F/rabbitmq/screenshots/9.png)


