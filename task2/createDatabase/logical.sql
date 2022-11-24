CREATE TABLE instructor (
 instructor_id SERIAL,
 first_name VARCHAR(500) NOT NULL,
 sur_name VARCHAR(500) NOT NULL,
 email VARCHAR(500) NOT NULL,
 ensemble VARCHAR(500) NOT NULL,
 person_number VARCHAR(500) NOT NULL,
 street VARCHAR(500) NOT NULL,
 city VARCHAR(500) NOT NULL,
 zip VARCHAR(500) NOT NULL,
 phone VARCHAR(500)
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (instructor_id);


CREATE TABLE instrument (
 instrument_id SERIAL NOT NULL,
 instrument VARCHAR(500) NOT NULL,
 brand VARCHAR(500) NOT NULL,
 rented BOOLEAN NOT NULL
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY ( instrument_id);


CREATE TABLE learn_instrument (
 id SERIAL,
 instrument VARCHAR(500) NOT NULL
);

ALTER TABLE learn_instrument ADD CONSTRAINT PK_learn_instrument PRIMARY KEY (id);


CREATE TABLE price (
 price_id SERIAL,
 type VARCHAR(500) NOT NULL,
 level VARCHAR(500),
 price VARCHAR(500) NOT NULL
);

ALTER TABLE price ADD CONSTRAINT PK_price PRIMARY KEY (price_id);


CREATE TABLE student (
 student_id SERIAL,
 first_name VARCHAR(500) NOT NULL,
 sur_name VARCHAR(500) NOT NULL,
 email VARCHAR(500) NOT NULL,
 person_number VARCHAR(500) NOT NULL,
 street VARCHAR(500) NOT NULL,
 zip VARCHAR(500) NOT NULL,
 city VARCHAR(500) NOT NULL,
 phone VARCHAR(500) NOT NULL
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (student_id);


CREATE TABLE student_learn_instrument (
 play_instrument_id SERIAL NOT NULL,
 student_id SERIAL NOT NULL
);

ALTER TABLE student_learn_instrument ADD CONSTRAINT PK_student_learn_instrument PRIMARY KEY (play_instrument_id,student_id);


CREATE TABLE student_sibling (
 student_id SERIAL NOT NULL,
 studnet_id SERIAL NOT NULL
);

ALTER TABLE student_sibling ADD CONSTRAINT PK_student_sibling PRIMARY KEY (student_id,studnet_id);


CREATE TABLE teach_instrument (
 id SERIAL NOT NULL,
 instrument VARCHAR(500) NOT NULL
);

ALTER TABLE teach_instrument ADD CONSTRAINT PK_teach_instrument PRIMARY KEY (id);


CREATE TABLE ensamble (
 ensamble_id SERIAL,
 place VARCHAR(500) NOT NULL,
 target_genre VARCHAR(500) NOT NULL,
 min_participants VARCHAR(500) NOT NULL,
 max_participants VARCHAR(500) NOT NULL,
 date VARCHAR(500) NOT NULL,
 time VARCHAR(500) NOT NULL,
 instructor_id SERIAL NOT NULL,
 price_id SERIAL NOT NULL
);

ALTER TABLE ensamble ADD CONSTRAINT PK_ensamble PRIMARY KEY (ensamble_id);


CREATE TABLE group_lesson (
 group_lesson_id SERIAL NOT NULL,
 instrument VARCHAR(500) NOT NULL,
 min_participants VARCHAR(500) NOT NULL,
 max_participants VARCHAR(500),
 level VARCHAR(500) NOT NULL,
 date VARCHAR(500) NOT NULL,
 time VARCHAR(500) NOT NULL,
 place VARCHAR(500) NOT NULL,
 price_id SERIAL NOT NULL,
 instructor_id SERIAL NOT NULL
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (group_lesson_id);


CREATE TABLE instructor_teach_instrument (
 teach_instrument_id SERIAL NOT NULL,
 instructor_id SERIAL NOT NULL,
 level VARCHAR(500) NOT NULL
);

ALTER TABLE instructor_teach_instrument ADD CONSTRAINT PK_instructor_teach_instrument PRIMARY KEY (teach_instrument_id,instructor_id);


CREATE TABLE rent_instrument (
  instrument_id SERIAL,
 fee VARCHAR(500) NOT NULL,
 start_at DATE NOT NULL,
 end_at DATE NOT NULL,
 student_id SERIAL
);

ALTER TABLE rent_instrument ADD CONSTRAINT PK_rent_instrument PRIMARY KEY (instrument_id);


CREATE TABLE skill_level (
 student_id SERIAL NOT NULL,
 instrument VARCHAR(500) NOT NULL,
 skill_level VARCHAR(500) NOT NULL
);

ALTER TABLE skill_level ADD CONSTRAINT PK_skill_level PRIMARY KEY (student_id);


CREATE TABLE student_ensamble (
 student_id SERIAL NOT NULL,
 ensamble_id SERIAL NOT NULL
);

ALTER TABLE student_ensamble ADD CONSTRAINT PK_student_ensamble PRIMARY KEY (student_id,ensamble_id);


CREATE TABLE student_group_lesson (
 student_id SERIAL NOT NULL,
 group_lesson_id SERIAL NOT NULL
);

ALTER TABLE student_group_lesson ADD CONSTRAINT PK_student_group_lesson PRIMARY KEY (student_id,group_lesson_id);


CREATE TABLE individual_lesson (
 individual_lessonid SERIAL,
 date VARCHAR(500) NOT NULL,
 time VARCHAR(500) NOT NULL,
 student_id SERIAL NOT NULL,
 price_id SERIAL NOT NULL,
 place VARCHAR(500) NOT NULL,
 teach_instrument_id SERIAL NOT NULL,
 instructor_id SERIAL NOT NULL
);

ALTER TABLE individual_lesson ADD CONSTRAINT PK_individual_lesson PRIMARY KEY (individual_lessonid);


ALTER TABLE student_learn_instrument ADD CONSTRAINT FK_student_learn_instrument_0 FOREIGN KEY (play_instrument_id) REFERENCES learn_instrument (id);
ALTER TABLE student_learn_instrument ADD CONSTRAINT FK_student_learn_instrument_1 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE student_sibling ADD CONSTRAINT FK_student_sibling_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE student_sibling ADD CONSTRAINT FK_student_sibling_1 FOREIGN KEY (studnet_id) REFERENCES student (student_id);


ALTER TABLE ensamble ADD CONSTRAINT FK_ensamble_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);
ALTER TABLE ensamble ADD CONSTRAINT FK_ensamble_1 FOREIGN KEY (price_id) REFERENCES price (price_id);


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (price_id) REFERENCES price (price_id);
ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_1 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);


ALTER TABLE instructor_teach_instrument ADD CONSTRAINT FK_instructor_teach_instrument_0 FOREIGN KEY (teach_instrument_id) REFERENCES teach_instrument (id);
ALTER TABLE instructor_teach_instrument ADD CONSTRAINT FK_instructor_teach_instrument_1 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);


ALTER TABLE rent_instrument ADD CONSTRAINT FK_rent_instrument_0 FOREIGN KEY ( instrument_id) REFERENCES instrument ( instrument_id);
ALTER TABLE rent_instrument ADD CONSTRAINT FK_rent_instrument_1 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE skill_level ADD CONSTRAINT FK_skill_level_0 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE student_ensamble ADD CONSTRAINT FK_student_ensamble_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE student_ensamble ADD CONSTRAINT FK_student_ensamble_1 FOREIGN KEY (ensamble_id) REFERENCES ensamble (ensamble_id);


ALTER TABLE student_group_lesson ADD CONSTRAINT FK_student_group_lesson_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE student_group_lesson ADD CONSTRAINT FK_student_group_lesson_1 FOREIGN KEY (group_lesson_id) REFERENCES group_lesson (group_lesson_id);


ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_1 FOREIGN KEY (price_id) REFERENCES price (price_id);
ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_2 FOREIGN KEY (teach_instrument_id,instructor_id) REFERENCES instructor_teach_instrument (teach_instrument_id,instructor_id);






