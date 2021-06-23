-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

USE shop;

-- заполним пустые таблицы данными
INSERT INTO orders (user_id)
VALUES (1),
  	   (3),
       (5),
       (6); 

INSERT INTO orders_products (order_id, product_id, total)
VALUES
  (1, 5, 7),
  (1, 2, 2),
  (2, 4, 3),
  (3, 3, 3),
  (3, 1, 1),
  (4, 4, 4),
  (4, 6, 5);
 
SELECT users.name, orders.id AS 'orders'
FROM users JOIN orders 
ON users.id = orders.user_id;

-- Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT p.name, c.name AS 'product type'
FROM catalogs AS c JOIN products AS p
ON c.id = p.catalog_id;


-- (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
-- Поля from, to и label содержат английские названия городов, поле name — русское. 
-- Выведите список рейсов flights с русскими названиями городов.

CREATE DATABASE flights;
USE flights;

CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  city_from VARCHAR(255) COMMENT 'Город вылета самолета',
  city_to VARCHAR(255) COMMENT 'Город прилета самолета',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Вылеты';

CREATE TABLE cities (
  id SERIAL PRIMARY KEY,
  label VARCHAR(255) COMMENT 'Английское название города',
  name VARCHAR(255) COMMENT 'Русское название города',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Города';

INSERT INTO flights (city_from, city_to)
VALUES
  ('moscow', 'omsk'),
  ('novgorod', 'kazan'),
  ('irkutsk', 'moscow'),
  ('omsk', 'irkutsk'),
  ('moscow', 'kazan');
 
INSERT INTO cities (label, name)
VALUES
  ('moscow', 'Москва'),
  ('irkutsk', 'Иркутск'),
  ('novgorod', 'Новгород'),
  ('kazan', 'Казань'),
  ('omsk', 'Омск');
 
SELECT f.id, c1.name AS 'city_from', c2.name AS 'city_to'
FROM
  flights AS f
JOIN cities c1 ON c1.label = f.city_from
JOIN cities c2 ON c2.label = f.city_to
ORDER BY f.id; 
