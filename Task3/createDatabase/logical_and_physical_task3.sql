CREATE TYPE INSTRUMENT_ENUM AS ENUM ('guitar', 'piano', 'saxophone', 'trumpet', 
'harmonica', 'fiol', 'cello', 'clarinett', 'double bass', 'violin');
CREATE TYPE LEVEL_ENUM AS ENUM ('beginner', 'intermediate','advanced');
CREATE TYPE TYPE_ENUM AS ENUM ('individual', 'group','ensamble');


CREATE TABLE instructor (
 id SERIAL,
 first_name VARCHAR(500) NOT NULL,
 sur_name VARCHAR(500) NOT NULL,
 email VARCHAR(500) NOT NULL,
 ensamble BOOLEAN NOT NULL,
 person_number VARCHAR(500) NOT NULL,
 street VARCHAR(500) NOT NULL,
 city VARCHAR(500) NOT NULL,
 zip VARCHAR(500) NOT NULL,
 phone VARCHAR(500)
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (id);


CREATE TABLE instructor_teach_instrument (
 instructor_id SERIAL,
 level LEVEL_ENUM NOT NULL,
 instrument INSTRUMENT_ENUM NOT NULL
);

ALTER TABLE instructor_teach_instrument ADD CONSTRAINT PK_instructor_teach_instrument PRIMARY KEY (instructor_id);


CREATE TABLE instrument_in_stock (
 id SERIAL,
 instrument INSTRUMENT_ENUM NOT NULL,
 brand VARCHAR(500) NOT NULL,
 rented BOOLEAN NOT NULL
);

ALTER TABLE instrument_in_stock ADD CONSTRAINT PK_instrument_in_stock PRIMARY KEY (id);


CREATE TABLE price (
 id SERIAL,
 type TYPE_ENUM NOT NULL,
 level  LEVEL_ENUM,
 price VARCHAR(500) NOT NULL
);

ALTER TABLE price ADD CONSTRAINT PK_price PRIMARY KEY (id);


CREATE TABLE student (
 id SERIAL,
 first_name VARCHAR(500) NOT NULL,
 sur_name VARCHAR(500) NOT NULL,
 email VARCHAR(500) NOT NULL,
 person_number VARCHAR(500) NOT NULL,
 street VARCHAR(500) NOT NULL,
 zip VARCHAR(500) NOT NULL,
 city VARCHAR(500) NOT NULL,
 phone VARCHAR(500) NOT NULL
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (id);


CREATE TABLE student_sibling (
 student_id SERIAL,
 student_id_0 SERIAL
);

ALTER TABLE student_sibling ADD CONSTRAINT PK_student_sibling PRIMARY KEY (student_id,student_id_0);


CREATE TABLE contact_person (
 id SERIAL,
 first_name VARCHAR(500) NOT NULL,
 email VARCHAR(500) NOT NULL,
 person_number VARCHAR(500) NOT NULL,
 sur_name VARCHAR(500) NOT NULL,
 phone VARCHAR(500) NOT NULL,
 student_id SERIAL
);

ALTER TABLE contact_person ADD CONSTRAINT PK_contact_person PRIMARY KEY (id);


CREATE TABLE ensamble (
 ensamble_id SERIAL,
 place VARCHAR(500) NOT NULL,
 target_genre VARCHAR(500) NOT NULL,
 min_participants VARCHAR(500) NOT NULL,
 max_participants VARCHAR(500) NOT NULL,
 date_and_time TIMESTAMP(6) NOT NULL,
 instructor_id SERIAL,
 price_id SERIAL
);

ALTER TABLE ensamble ADD CONSTRAINT PK_ensamble PRIMARY KEY (ensamble_id);


CREATE TABLE group_lesson (
 group_lesson_id SERIAL,
 instrument INSTRUMENT_ENUM NOT NULL,
 min_participants VARCHAR(500) NOT NULL,
 max_participants VARCHAR(500),
 level LEVEL_ENUM NOT NULL,
 date_and_time TIMESTAMP(6) NOT NULL,
 place VARCHAR(500) NOT NULL,
 price_id SERIAL,
 instructor_id SERIAL 
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (group_lesson_id);


CREATE TABLE individual_lesson (
 individual_lesson_id SERIAL ,
 date_and_time TIMESTAMP(6) NOT NULL,
 student_id SERIAL ,
 price_id SERIAL ,
 place VARCHAR(500) NOT NULL,
 instructor_id SERIAL 
);

ALTER TABLE individual_lesson ADD CONSTRAINT PK_individual_lesson PRIMARY KEY (individual_lesson_id);


CREATE TABLE rent_instrument (
 instrument_in_stock_id SERIAL ,
 fee VARCHAR(500) NOT NULL,
 start_at DATE NOT NULL,
 end_at DATE NOT NULL,
 student_id SERIAL
);

ALTER TABLE rent_instrument ADD CONSTRAINT PK_rent_instrument PRIMARY KEY (instrument_in_stock_id);


CREATE TABLE skill_level (
 student_id SERIAL ,
 instrument INSTRUMENT_ENUM NOT NULL,
 level  LEVEL_ENUM NOT NULL
);

ALTER TABLE skill_level ADD CONSTRAINT PK_skill_level PRIMARY KEY (student_id);


CREATE TABLE student_ensamble (
 student_id SERIAL ,
 ensamble_id SERIAL 
);

ALTER TABLE student_ensamble ADD CONSTRAINT PK_student_ensamble PRIMARY KEY (student_id,ensamble_id);


CREATE TABLE student_group_lesson (
 student_id SERIAL ,
 group_lesson_id SERIAL 
);

ALTER TABLE student_group_lesson ADD CONSTRAINT PK_student_group_lesson PRIMARY KEY (student_id,group_lesson_id);


ALTER TABLE instructor_teach_instrument ADD CONSTRAINT FK_instructor_teach_instrument_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE student_sibling ADD CONSTRAINT FK_student_sibling_0 FOREIGN KEY (student_id) REFERENCES student (id);
ALTER TABLE student_sibling ADD CONSTRAINT FK_student_sibling_1 FOREIGN KEY (student_id_0) REFERENCES student (id);


ALTER TABLE contact_person ADD CONSTRAINT FK_contact_person_0 FOREIGN KEY (student_id) REFERENCES student (id);


ALTER TABLE ensamble ADD CONSTRAINT FK_ensamble_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id);
ALTER TABLE ensamble ADD CONSTRAINT FK_ensamble_1 FOREIGN KEY (price_id) REFERENCES price (id);


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (price_id) REFERENCES price (id);
ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_1 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_0 FOREIGN KEY (student_id) REFERENCES student (id);
ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_1 FOREIGN KEY (price_id) REFERENCES price (id);
ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_2 FOREIGN KEY (instructor_id) REFERENCES instructor_teach_instrument (instructor_id);


ALTER TABLE rent_instrument ADD CONSTRAINT FK_rent_instrument_0 FOREIGN KEY (instrument_in_stock_id) REFERENCES instrument_in_stock (id);
ALTER TABLE rent_instrument ADD CONSTRAINT FK_rent_instrument_1 FOREIGN KEY (student_id) REFERENCES student (id);


ALTER TABLE skill_level ADD CONSTRAINT FK_skill_level_0 FOREIGN KEY (student_id) REFERENCES student (id);


ALTER TABLE student_ensamble ADD CONSTRAINT FK_student_ensamble_0 FOREIGN KEY (student_id) REFERENCES student (id);
ALTER TABLE student_ensamble ADD CONSTRAINT FK_student_ensamble_1 FOREIGN KEY (ensamble_id) REFERENCES ensamble (ensamble_id);


ALTER TABLE student_group_lesson ADD CONSTRAINT FK_student_group_lesson_0 FOREIGN KEY (student_id) REFERENCES student (id);
ALTER TABLE student_group_lesson ADD CONSTRAINT FK_student_group_lesson_1 FOREIGN KEY (group_lesson_id) REFERENCES group_lesson (group_lesson_id);

