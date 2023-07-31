CREATE TABLE IF NOT EXISTS users
(
    id       SERIAL,
    username VARCHAR(255),
    password VARCHAR(255),
    image    VARCHAR(255) DEFAULT NULL
);

-- INSERT INTO users(username, password)
-- VALUES ('username', '12345678'),
--        ('username1', '12345678'),
--        ('username2', '12345678'),
--        ('username', '12345678'),
--        ('username', '12345678'),
--        ('username', '12345678');

DELETE
FROM users
WHERE id IN
      (SELECT id
       FROM (SELECT id,
                    ROW_NUMBER() OVER ( PARTITION BY username,
                        username
                        ORDER BY id ) AS row_num
             FROM users) t
       WHERE t.row_num > 1);

SELECT *
FROM users
ORDER BY id ASC;