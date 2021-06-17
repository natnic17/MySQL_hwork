USE vk_data;

DESCRIBE media_types;

SELECT * FROM media_types;

UPDATE media_types 
SET name =  'image' WHERE id = 1;

UPDATE media_types 
SET name =  'audio' WHERE id = 2;

UPDATE media_types 
SET name =  'video' WHERE id = 3;

UPDATE media_types 
SET name =  'document' WHERE id = 4;

SELECT * FROM friend_requests;

DELETE FROM friend_requests WHERE from_user_id = to_user_id;