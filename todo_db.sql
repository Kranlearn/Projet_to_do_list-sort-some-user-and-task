USE todo_db;

CREATE TABLE users (
id INT AUTO_INCREMENT PRIMARY KEY, username VARCHAR(50) NOT NULL);
ALTER TABLE users
CHANGE COLUMN userman username VARCHAR(50) NOT NULL;

CREATE TABLE tasks (id INT AUTO_INCREMENT PRIMARY KEY, 
title VARCHAR(225) NOT NULL
);
ALTER TABLE tasks
    ADD COLUMN user_id INT,
    ADD COLUMN completed BOOLEAN DEFAULT 
    FALSE,
    ADD COLUMN created_at TIMESTAMP
    DEFAULT CURRENT_TIMESTAMP,
    ADD COLUMN updated_at TIMESTAMP
    DEFAULT CURRENT_TIMESTAMP ON UPDATE 
    CURRENT_TIMESTAMP;
    ALTER TABLE tasks
    ADD FOREIGN KEY (user_id) REFERENCES 
    users(id);
INSERT INTO users (username) VALUES 
('Moo'),
 ('DevTest'),
 ('PlayerOne');

INSERT INTO TASKS (TITLE, user_id)
VALUE 
('Ma première Task', 1),
('Apprendre les relations SQL', 1),
('Task test avec user', 2),
('Nouvelle task test', 3);

SHOW TABLES;
DESCRIBE users;
DESCRIBE tasks;

SELECT tasks.id, tasks.title,
 tasks.completed, users.username, 
tasks.created_at, tasks.updated_at
FROM tasks
LEFT JOIN users ON tasks.user_id = user.id 
LIMIT 10;
/*JOIN USERS AND TASKS*/

UPDATE tasks
SET completed = TRUE 
WHERE id = 1;
SELECT tasks.id, tasks.title, 
tasks.completed, tasks.updated_at FROM tasks
JOIN users ON tasks.user_id = users.id;
DESCRIBE tasks;
SELECT tasks.id, tasks.title,
 tasks.completed, users.username
FROM tasks
JOIN users ON tasks.user_id = users.id 
WHERE users.id = 1;

SELECT tasks.id, tasks.title,
tasks.completed, users.username
FROM tasks
JOIN users ON tasks.user_id = users.id
WHERE tasks.completed = FALSE;

SELECT tasks.id, tasks.title, 
tasks.completed, users.username
FROM tasks
JOIN users ON tasks.users_id = users.id
WHERE tasks.completed = TRUE;

SELECT users.username, COUNT(tasks.id)
AS total_tasks
FROM users
LEFT JOIN tasks ON tasks.user_id = users.id
GROUP BY users.id;

UPDATE tasks
SET completed = TRUE
WHERE user_id = 2;

SELECT tasks.id, tasks.title,
tasks.completed, users.username, 
tasks.created_at 
FROM tasks
JOIN users ON tasks.user_id = users.id ORDER BY tasks.created_at DESC;

CREATE TABLE projects (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR (100) NOT NULL,
created_at TIMESTAMP DEFAULT 
CURRENT_TIMESTAMP
); 
ALTER TABLE tasks
ADD COLUMN project_id INT, 
ADD FOREIGN KEY (project_id)
REFERENCES prejects(id);

INSERT INTO projects (name) VALUES
('Projet Alpha'),
('Projet Beta'),
('Projet Gamma');

UPDATE tasks
SET project_id = 1 
WHERE id = 1;

UPDATE tasks 
SET project_id = 2
WHERE id = 2;

ALTER TABLE tasks
ADD column project_id INT;
SELECT tasks.id, tasks.title, 
tasks.completed, users.username,
projects.name AS project,
tasks.created_at
FROM tasks
JOIN users ON tasks.user_id = users.id
LEFT JOIN projects ON tasks.projects_id = project.id
ORDER BY tasks.created_at DESC;

DROP VIEW IF EXISTS view_tasks_full;
CREATE OR REPLACE VIEW view_tasks_full 
AS
SELECT tasks.id, tasks.title,
tasks.status, task.priority, tasks.deadline,
 tasks.completed, users.username, 
 projects.name AS project_name,
 tasks.created_at
 FROM tasks
 JOIN users ON tasks.user_id = users.id 
 LEFT JOIN projects ON tasks.project_id = projects.id;
SELECT * FROM view_tasks_full;

ALTER TABLE tasks
ADD COLUMN priority ENUM('low', 'medium', 'high')
 DEFAULT 'medium', ADD COLUMN deadline DATE;


ALTER TABLE tasks ADD COLUMN statue ENUM('pending', 'in_progress', 'completed') 
DEFAULT 'pending';

SELECT * FROM tasks 
WHERE priority = 'high'
AND status != 'Completed';

SELECT * FROM tasks 
WHERE deadline < CURDATE()
AND status != 'Completed';

SELECT priority, COUNT(*) AS total FROM tasks
GROUP BY priority;

SELECT * FROM tasks
WHERE deadline IS NOT NULL
AND deadline < CURDATE()
AND completed = FALSE; 

SELECT * FROM tasks
WHERE priority = 'high'
AND completed = FALSE 
ORDER BY deadline ASC;

SELECT users.username, COUNT (total.id) AS total_tasks,
SUM(total.completed = TRUE) AS completed_tasks FROM users u 
LEFT JOIN tasks t ON u.id = t.user_id GROUP BY u.username;

SELECT COUNT(*) AS total,
SUM(completed = TRUE) AS completed,
ROUND(SUM(completed = TRUE) / COUNT(*) * 100, 2) AS completion_rate_percent 
 FROM tasks;

ALTER TABLE tasks
ADD COLUMN late BOOLEAN DEFAULT FALSE;

DELIMITER //
CREATE TRIGGER before_task_update 
 BEFORE UPDATE ON tasks
 FOR EACH ROW 
 BEGIN
	IF NEW.deadline IS NOT NULL
		AND NEW.deadline < CURDATE()
        AND NEW.completed = FALSE THEN 
        SET NEW.late = TRUE;
	ELSE 
		SET NEW.late = FALSE;
END IF;
END //
DELIMITER ;
UPDATE tasks SET title = 'Test late' 
WHERE id = 1;
