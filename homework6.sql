USE vk_data;

-- Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

SELECT (SELECT firstname FROM users WHERE users.id = messages.from_user_id) AS sender_name,
(SELECT lastname FROM users WHERE users.id = messages.from_user_id) AS sender_lastname,
COUNT(*) AS msg_sent
FROM messages WHERE to_user_id = 1
GROUP BY from_user_id 
ORDER BY msg_sent DESC
LIMIT 1;

-- Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.


SELECT COUNT(*) FROM posts_likes WHERE post_id IN (
	SELECT id FROM posts WHERE user_id IN (
	SELECT user_id FROM profiles WHERE YEAR(curdate()) - YEAR(birthday) < 18
	)
) AND like_type = 1;


-- Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT (SELECT gender FROM profiles WHERE profiles.user_id = posts_likes.user_id) AS gender,
	COUNT(*) AS num_of_likes
FROM posts_likes
WHERE like_type = 1
GROUP BY gender
HAVING gender IN ('m', 'f')
ORDER BY num_of_likes DESC;


-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.

SELECT firstname, lastname,
	(SELECT COUNT(*) FROM media WHERE media.user_id = users.id) AS media,
	(SELECT COUNT(*) FROM posts WHERE posts.user_id = users.id) AS posts,
	(SELECT COUNT(*) FROM messages WHERE messages.from_user_id = users.id) AS msg
FROM users;

SELECT firstname, lastname,
	(SELECT COUNT(*) FROM media WHERE media.user_id = users.id) +
	(SELECT COUNT(*) FROM posts WHERE posts.user_id = users.id) +
	(SELECT COUNT(*) FROM messages WHERE messages.from_user_id = users.id) AS sum_activity
FROM users
ORDER BY sum_activity
LIMIT 10;

