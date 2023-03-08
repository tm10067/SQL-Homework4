/* Урок 4. SQL – работа с несколькими таблицами. Практическое задание.
Подсчитать количество групп, в которые вступил каждый пользователь.
Подсчитать количество пользователей в каждом сообществе.
Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, 
который больше всех общался с выбранным пользователем (написал ему сообщений).
* Подсчитать общее количество лайков, которые получили пользователи младше 18 лет.
* Определить кто больше поставил лайков (всего): мужчины или женщины. */

USE vk;

/* Подсчитать количество групп, в которые вступил каждый пользователь. */

  SELECT users.lastname, users.firstname, COUNT(community_id) AS communities_count
    FROM users 
    JOIN users_communities ON users.id = users_communities.user_id
GROUP BY users.id
ORDER BY users.lastname;

/* Подсчитать количество пользователей в каждом сообществе. */

  SELECT communities.name AS community, COUNT(user_id) AS users_count
    FROM communities
    JOIN users_communities ON communities.id = users_communities.community_id
GROUP BY communities.id
ORDER BY communities.name;

/* Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, 
который больше всех общался с выбранным пользователем (написал ему сообщений). */

     SET @target_user_id = 1;           -- Зададим целевого пользователя с id = 1
     
  SELECT users.firstname, users.lastname
    FROM messages 
    JOIN users ON messages.from_user_id = users.id
   WHERE to_user_id = @target_user_id                   
GROUP BY from_user_id 
ORDER BY COUNT(messages.id) DESC
   LIMIT 1;

/* Подсчитать общее количество лайков, которые получили пользователи младше 18 лет. */

SELECT COUNT(likes.id) AS likes_to_youngs
  FROM likes
  JOIN media ON likes.media_id = media.id
  JOIN profiles ON media.user_id = profiles.user_id
 WHERE profiles.birthday > DATE_ADD(CURDATE(), INTERVAL -18 YEAR);

/* Определить кто больше поставил лайков (всего): мужчины или женщины. */

  SELECT profiles.gender AS most_likes_given_by_gender
    FROM likes 
    JOIN profiles ON likes.user_id = profiles.user_id
GROUP BY profiles.gender
ORDER BY COUNT(likes.id) DESC
   LIMIT 1;
