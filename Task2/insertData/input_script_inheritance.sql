-- 1. INSTRUMENT
-- 2. LEARN INSTRUMENT  (Should this really be in the database, better if the studnet writes a comment)
-- 3. PERSON
-- 4. PHONE


-- INSTRUMENT
INSERT INTO instrument (instrument, brand, rented) 
VALUES
('Guitar', 'Roland', true),
('Piano', 'Roland', true),
('Saxophone', 'Roland', true),
('Trumpet', 'Roland', true),
('Harmonico', 'Ibanez', true); 


--LEARN INSTRUMENT 
INSERT INTO learn_instrument (instrument) 
VALUES
('Guitar'),
('Piano'),
('Saxophone'),
('Trumpet'),
('Harmonico'); 


--PERSON
INSERT INTO person (person_number,first_name,sur_name,email,street,zip,city)
VALUES
  ('9510338284','Graham','Böhm','graham@icloud.couk','5278 Integer Av.','68743','Avesta'),
  ('0016491065','Emi','Obermeyer','emi8470@outlook.net','280-5412 Et St.','11771','Söderhamn'),
  ('8947069236','Arden','Bäcker','arden2696@aol.com','448-8867 Sociosqu Rd.','65637','Värnamo'),
  ('6705072420','Malik','Schubert','malik8038@icloud.net','968-2257 Arcu Ave','51477','Alingsås'),
  ('0654619949','Malin','Zimmermann','igor1510@protonmail.couk','P.O. Box 330, 6336 Nisl. St.','03864','Sandviken'),
  ('0654619949','Vanessa','Zimmermann','igor1510@protonmail.couk','P.O. Box 330, 6336 Nisl. St.','03864','Sandviken'),
  ('5754619949','Igor','Zimmermann','igor1510@protonmail.couk','P.O. Box 330, 6336 Nisl. St.','03864','Sandviken');


-- PHONE
INSERT INTO phone (id,phone_num)
VALUES
  ('(0601) 38348346'),
  ('(038731) 210680'),
  ('(030832) 440688'),
  ('(05726) 7813487'),
  ('(032363) 264372'),
  ('(032363) 264372'),
  ('(032363) 264372');

--PERSON PHONE
INSERT INTO person_phone (phone_id,person_id)
VALUES
  (1,1),
  (2,2),
  (3,3),
  (4,4),
  (5,5),
  (6,6),
  (7,7);

--PRICE
INSERT INTO price (type,level,price)
VALUES
  ('ensamble',NULL,200),
  ('group','beginner',100),
  ('group','intermediate',200),
  ('group','advanced',300),
  ('individual',NULL,100);

--STUDENT
INSERT INTO student (person_id, contact_person) 
VALUES
 (1, 'Herman'),
 (2, 'Agneta'),
 (5, 'Peter'),
 (6, 'Leif');

--STUDENT_LEARN_INSTRUMENT
INSERT INTO student_learn_instrument(play_instrument_id,person_id)
(1,1),--(Guitar, student_person_id 1)
(1,2),--(Guitar, student_person_id 2)
(1,3),--(Saxophone, student_person_id 1)
(1,3),--(Trumpet, student_person_id 1)
(2,5),--(Piano, student_person_id 5)
(2,6);--(Piano, student_person_id 6)

--STUDENT_SIBLING
INSERT INTO student_sibling(person_id, person_id_0)
(1,2), -- person_id = student, person_id_o = sibling
(2,1),
(5,6),
(6,5);

--INSTRUCTOR
INSERT INTO instructor(person_id, ensamble) 
(3,true),
(4,false);

--TEACH_INSTRUMENT
INSERT INTO teach_instrument (instrument) 
VALUES
('Guitar'),
('Piano'),
('Saxophone'),
('Trumpet'),
('Harmonico'); 

--INSTRUCTOR_TEACH_INSTRUMENT
INSERT INTO instructor_teach_instrument (instructor_id, teach_instrument_id) 
VALUES
(3,1),
(3,2),
(4,3),
(4,5),
(4,6); 

--LESSON
INSERT INTO lesson(date_and_time,instructor_person_id,price_id,place) 
('2022.11.22 10.00-11.00',3,1,'A'), -- person_id = 3, Ensamble, Sal A. 
('2022.11.22 11.00-12.00',3,2,'A'), -- person_id = 3, Group beginner, Sal A. 
('2022.11.22 12.00-13.00',3,5,'A'), -- person_id = 3, Individual, Sal A. 
('2022.11.22 10.00-11.00',4,3,'B'), -- person_id = 3, Group Intermediate, Sal A. 
('2022.11.22 11.00-12.00',4,4,'B'); -- person_id = 3, Group Advanced, Sal A. 

--RENT_INSTRUMENT
INSERT INTO rent_instrument(instrument_id,fee,start_at,end_at,person_id)
(1,'400', '2022.01.01','2022.04.01',1),
(2,'400', '2022.01.01','2022.04.01',2),
(3,'200', '2022.06.01','2022.08.01',5);

--SKILL_LEVEL
INSERT INTO skill_level (person_id, instrument, skill_level)
(1,'Piano','Beginner'),
(1,'Guitar', 'Intermediate'),
(2,'Piano', 'Beginner'),
(5, 'Piano','Beginner'),
(6, 'Piano','Beginner');

--STUDENT_LESSON
INSERT INTO student_lesson(lesson_id, person_id)
(1,1),
(1,2),
(1,5),
(1,6),
(3,1),
(2,1),
(2,2),
(2,5),
(2,6);

--ENSAMBLE
INSERT INTO ensamble(lesson_id,target_genre,min_participants,max_participants)
(1,'Piano','10','40');

--GROUP_LESSON
INSERT INTO group_lesson(lesson_id,instrument,min_participants,max_participants,level) 
(2, 'Piano', '5', NULL,'Beginner'),
(4, 'Saxophone', '5', NULL,'Intermediate'),
(5, 'Saxophone', '5', NULL,'Advanced');

--INDIVIDUAL_LESSON
INSERT INTO individual_lesson(lesson_id)
(3); 




