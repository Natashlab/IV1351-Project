-- Show the number of lessons given per month during a specified year.
-- It shall be possible to retrieve the total number of lessons per month (just one number per month) 
-- and the specific number of individual lessons, group lessons and ensembles (three numbers per month). 

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
WHERE EXTRACT(YEAR FROM CAST(ensamble.date_and_time AS timestamp)) = 2022
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



-- Show how many students there are with no sibling, with one sibling and with two siblings.

SELECT COUNT(*) AS students, siblings
FROM (SELECT student_id, SUM(CASE WHEN student_id IN (SELECT student_id FROM student_sibling) THEN 1 ELSE 0 END) AS siblings
FROM student_sibling GROUP BY student_id) AS x
GROUP BY siblings
UNION SELECT COUNT(*), 0
FROM student WHERE id
NOT IN (SELECT student_id from student_sibling)
ORDER BY siblings;

-- List all instructors who has given more than a specific number of lessons during the current month.
-- Sum all lessons, independent of type, and sort the result by the number of given lessons. 

SELECT 
    instructor_id,
    COUNT(*) AS amount
FROM
    ((SELECT
        instructor_id
    FROM 
        individual_lesson 
        WHERE EXTRACT(MONTH FROM date_and_time)=12)
    UNION ALL
    (SELECT
        instructor_id
    FROM
        group_lesson 
        WHERE EXTRACT(MONTH FROM date_and_time)=12)
    UNION ALL
    (SELECT
        instructor_id
    FROM
        ensamble 
        WHERE EXTRACT(MONTH FROM date_and_time)=12)) AS foo
    GROUP BY 1
    HAVING COUNT(*) > 1;



-- List all ensembles held during the next week, sorted by music genre and weekday.
-- For each ensemble tell whether it's full booked, has 1-2 seats left or has more seats left. 

SELECT ensamble.date_and_time AS weekday , ensamble.target_genre AS genre,
(CASE 
	WHEN COUNT (student_ensamble.student_id) = (20) THEN 'Fully booked'
	WHEN COUNT (student_ensamble.student_id) = (19) THEN '1 seats left'
    WHEN COUNT (student_ensamble.student_id) = (18) THEN '2 seats left'
    END)
FROM ensamble, student_ensamble
WHERE ensamble.ensamble_id = student_ensamble.ensamble_id AND date_trunc('week', current_date + interval '1 week')=date_trunc('week', date_and_time)
GROUP BY weekday, genre;


