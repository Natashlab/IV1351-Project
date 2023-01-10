-- Show the number of lessons given per month during a specified year.
-- This query is expected to be performed a few times per week. 
-- It shall be possible to retrieve the total number of lessons per month (just one number per month) 
-- and the specific number of individual lessons, group lessons and ensembles (three numbers per month). 
-- It's not required that all four numbers (total plus one per lesson type) for a particular month are on the same row; 
-- you're allowed to have one row for each number as long as it's clear to which month each number belongs. However, 
-- it's most likely easier to understand the result if you do place all numbers for a particular month on the same row, 
-- and it's an interesting exercise, therefore you're encouraged to try.

SELECT EXTRACT (MONTH FROM CAST(group_lesson.date_and_time AS timestamp)) AS month,
COUNT(*)
FROM group_lesson
WHERE EXTRACT(YEAR FROM CAST(group_lesson.date_and_time AS timestamp)) = 2022
GROUP BY month;

SELECT EXTRACT (MONTH FROM CAST(group_lesson.date_and_time AS timestamp)) AS month,
COUNT(*)
FROM group_lesson
WHERE EXTRACT(YEAR FROM CAST(group_lesson.date_and_time AS timestamp)) = 2021
GROUP BY month;

-- select all from individual_lesson for a specific year

SELECT EXTRACT (MONTH FROM CAST(individual_lesson.date_and_time AS timestamp)) AS month,
COUNT(*)
FROM individual_lesson
WHERE EXTRACT(YEAR FROM CAST(individual_lesson.date_and_time AS timestamp)) = 2021
GROUP BY month;

SELECT EXTRACT (MONTH FROM CAST(individual_lesson.date_and_time AS timestamp)) AS month,
COUNT(*)
FROM individual_lesson
WHERE EXTRACT(YEAR FROM CAST(individual_lesson.date_and_time AS timestamp)) = 2022
GROUP BY month;

-- select all from ensamble for a specific year

SELECT EXTRACT (MONTH FROM CAST(ensamble.date_and_time AS timestamp)) AS month,
COUNT(*)
FROM ensamble
WHERE EXTRACT(YEAR FROM CAST(ensamble.date_and_time AS timestamp)) = 2021
GROUP BY month;

-- select count from all lesson types and a total number of lessons.

SELECT (SELECT COUNT (date_and_time) FROM ensamble WHERE date_and_time BETWEEN '2022-01-01' AND '2022-12-31') AS ensamble,
(SELECT COUNT (date_and_time) FROM group_lesson WHERE date_and_time BETWEEN '2022-01-01' AND '2022-12-31') AS group_lesson,
(SELECT COUNT (date_and_time) FROM individual_lesson WHERE date_and_time BETWEEN '2022-01-01' AND '2022-12-31') AS individual_lesson,
((SELECT COUNT (date_and_time) FROM ensamble WHERE date_and_time BETWEEN '2022-01-01' AND '2022-12-31') +
(SELECT COUNT (date_and_time) FROM group_lesson WHERE date_and_time BETWEEN '2022-01-01' AND '2022-12-31') +
(SELECT COUNT (date_and_time) FROM individual_lesson WHERE date_and_time BETWEEN '2022-01-01' AND '2022-12-31'))  AS total;


SELECT (SELECT COUNT (*) FROM ensamble WHERE date_and_time BETWEEN '2022-01-01' AND '2022-12-31') AS ensamble,
(SELECT COUNT (*) FROM group_lesson WHERE date_and_time BETWEEN '2022-01-01' AND '2022-12-31') AS group_lesson,
(SELECT COUNT (*) FROM individual_lesson WHERE date_and_time BETWEEN '2022-01-01' AND '2022-12-31') AS individual_lesson,
((SELECT COUNT (*) FROM ensamble WHERE date_and_time BETWEEN '2022-01-01' AND '2022-12-31') +
(SELECT COUNT (*) FROM group_lesson WHERE date_and_time BETWEEN '2022-01-01' AND '2022-12-31') +
(SELECT COUNT (*) FROM individual_lesson WHERE date_and_time BETWEEN '2022-01-01' AND '2022-12-31'))  AS total;



-- Show how many students there are with no sibling, with one sibling, with two siblings, etc.
-- This query is expected to be performed a few times per week. The database must contain students with no sibling, 
-- one sibling and two siblings, but doesn't have to contain students with more than two siblings. 
-- Note that it's not allowed to solve this by just adding a column with sibling count (maybe called no_of_siblings or something similar) 
-- to the student table. Such a solution would be almost impossible to maintain since it doesn't tell who's a sibling of who. 
-- If a student quits, there wont be any way to update the sibling count of that student's siblings.

SELECT COUNT(*) AS students, siblings
FROM (SELECT student_id, SUM(CASE WHEN student_id IN (SELECT student_id FROM student_sibling) THEN 1 ELSE 0 END) AS siblings
FROM student_sibling GROUP BY student_id) AS x
GROUP BY siblings
UNION SELECT COUNT(*), 0
FROM student WHERE id
NOT IN (SELECT student_id from student_sibling)
ORDER BY siblings;


SELECT student_id, COUNT(*)
FROM student_sibling 
GROUP BY student_id 
HAVING COUNT(*) = 0;

SELECT student_id, COUNT(*)
FROM student_sibling 
GROUP BY student_id 
HAVING COUNT(*) = 1;


SELECT student_id, COUNT(*)
FROM student_sibling 
GROUP BY student_id 
HAVING COUNT(*) = 2;

-- List all instructors who has given more than a specific number of lessons during the current month.
-- Sum all lessons, independent of type, and sort the result by the number of given lessons. 
-- This query will be used to find instructors risking to work too much, and will be executed daily.


-- funkar

SELECT instructor_id, COUNT(*) 
FROM group_lesson
GROUP BY instructor_id
HAVING COUNT(*) > 2;


-- står utan count 
SELECT instructor_id
FROM individual_lesson
GROUP BY instructor_id
HAVING COUNT(*) > 2;

SELECT(
SELECT COUNT(instructor_id) FROM individual_lesson) + (SELECT COUNT(instructor_id) FROM group_lesson)
GROUP BY instructor_id
HAVING COUNT(*) > 2;



-- List all ensembles held during the next week, sorted by music genre and weekday.
-- For each ensemble tell whether it's full booked, has 1-2 seats left or has more seats left. 
-- Hint: you might want to use a CASE statement in your query to produce the desired output.

SELECT ensamble_id, COUNT(*) FROM student_ensamble
GROUP BY ensamble_id
HAVING COUNT(*) < CAST(ensamble.max_participants AS INTEGER);


--räkna hur många delagare det är på varje ensamble lektion. 
SELECT ensamble_id, COUNT(*) FROM student_ensamble
GROUP BY ensamble_id
ORDER BY COUNT DESC; 


SELECT ensamble_id FROM student_ensamble


SELECT ensamble_id COUNT(*)
FROM student_ensamble 
WHERE 

SELECT se.ensamble_id, e.max_participants 
FROM student_ensamble AS se, ensamble as e;


SELECT student_ensamble.ensamble_id FROM student_ensamble 
JOIN ensamble 
ON student_ensamble.ensamble_id = ensamble.ensamble_id; 



SELECT ensamble.max_participants, ensamble.ensamble_id
FROM ensamble
RIGHT JOIN student_ensamble
ON ensamble.ensamble_id = student_ensamble.ensamble_id;



SELECT COUNT(student_ensamble.ensamble_id) 
FROM student_ensamble
GROUP BY student_ensamble.ensamble_id
HAVING COUNT(student_ensamble.ensamble_id) < ensamble.max_participants FROM ensamble; 



SELECT ensamble.max_participants, student_ensamble.ensamble_id, COUNT(student_ensamble.ensamble_id) AS number_of_participants
FROM (student_ensamble
JOIN ensamble ON student_ensamble.ensamble_id = ensamble.ensamble_id)
GROUP BY student_ensamble.ensamble_id,
HAVING COUNT(student_ensamble.ensamble_id) < ensamble.max_participants;




--Get all ensembles next week
SELECT ts.date,
CASE WHEN EXTRACT(DOW FROM ts.date) = 0 THEN 'Monday'
	WHEN EXTRACT(DOW FROM ts.date) = 1 THEN 'Tuesday'
	WHEN EXTRACT(DOW FROM ts.date) = 2 THEN 'Wednesday'
	WHEN EXTRACT(DOW FROM ts.date) = 3 THEN 'Thursday'
	WHEN EXTRACT(DOW FROM ts.date) = 4 THEN 'Friday'
	WHEN EXTRACT(DOW FROM ts.date) = 5 THEN 'Saturday'
	WHEN EXTRACT(DOW FROM ts.date) = 6 THEN 'Sunday'
END AS day, g.genre, 
CASE WHEN e.max_students - COUNT(student_id) FILTER (WHERE student_id IN (SELECT student_id FROM ensemble_student)) > 2 THEN '2+ spots left'
	WHEN e.max_students - COUNT(student_id) FILTER (WHERE student_id IN (SELECT student_id FROM ensemble_student)) = 2 THEN '2 spots left'
	WHEN e.max_students - COUNT(student_id) FILTER (WHERE student_id IN (SELECT student_id FROM ensemble_student)) = 1 THEN '1 spot left'
	WHEN e.max_students - COUNT(student_id) FILTER (WHERE student_id IN (SELECT student_id FROM ensemble_student)) = 0 THEN 'Fully booked'
	WHEN e.max_students - COUNT(student_id) FILTER (WHERE student_id IN (SELECT student_id FROM ensemble_student)) < 0 THEN 'Over booked'
END AS spots
FROM timeslot AS ts
NATURAL JOIN ensemble AS e
NATURAL JOIN genre AS g
NATURAL JOIN ensemble_student AS es
WHERE (SELECT EXTRACT(WEEK FROM ts.date) = EXTRACT(WEEK FROM CURRENT_DATE + INTERVAL '1 WEEK'))
GROUP BY ts.date, g.genre, e.max_students ORDER BY EXTRACT(DOW FROM ts.date), genre;