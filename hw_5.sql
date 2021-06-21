USE shop;

-- Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
UPDATE users SET created_at = NOW(), updated_at = NOW();


-- Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR
-- и в них долгое время помещались значения в формате 20.10.2017 8:10. Необходимо преобразовать поля к типу DATETIME,
-- сохранив введённые ранее значения.

ALTER TABLE users 
  MODIFY COLUMN created_at VARCHAR(255),
  MODIFY COLUMN updated_at VARCHAR(255);
  
ALTER TABLE users 
  MODIFY COLUMN created_at DATETIME,
  MODIFY COLUMN updated_at DATETIME;



-- В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 
-- 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом,
-- чтобы они выводились в порядке увеличения значения value. Однако нулевые запасы должны выводиться в конце,
-- после всех записей.

 INSERT INTO
  storehouses_products (storehouse_id, product_id, value)
VALUES
  (1, 1, 0),
  (2, 2, 17),
  (3, 3, 0),
  (4, 4, 33),
  (5, 5, 55);
 
SELECT * FROM storehouses_products ORDER BY IF(value > 0, 0, 1), value;



-- (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае.
-- Месяцы заданы в виде списка английских названий (may, august)

SELECT id, name, birthday_at FROM users WHERE MONTHNAME(birthday_at) IN ('may', 'august');

-- (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса.
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.

SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);

-- Подсчитайте средний возраст пользователей в таблице users.

SELECT name, TIMESTAMPDIFF(YEAR, birthday_at, NOW()) AS age FROM users;
SELECT FLOOR(AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW()))) AS avg_age FROM users;

-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.

SELECT
  DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day,
  COUNT(*) AS total
FROM
  users
GROUP BY
  day
ORDER BY
  total DESC;


-- (по желанию) Подсчитайте произведение чисел в столбце таблицы.

SELECT EXP(SUM(LN(price))) from products;
