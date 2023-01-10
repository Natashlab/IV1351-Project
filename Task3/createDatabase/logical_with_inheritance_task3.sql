CREATE TYPE INSTRUMENT_ENUM AS ENUM ('guitar', 'piano', 'saxophone', 'trumpet', 
'harmonica', 'fiol', 'cello', 'clarinett', 'double bass', 'violin');
CREATE TYPE LEVEL_ENUM AS ENUM ('beginner', 'intermediate','advanced');
CREATE TYPE TYPE_ENUM AS ENUM ('individual', 'group','ensamble');
CREATE TYPE BRAND_ENUM AS ENUM('Roland', 'Gibson', 'Yamaha', 'Fender Musical', 'Sennheiser', 'Harman Professional','Shure');
CREATE TYPE GENRE_ENUM AS ENUM('punk', 'rock', 'jazz', 'punkrock', 'classical');


CREATE TABLE instrument (
 id SERIAL,
 instrument INSTRUMENT_ENUM NOT NULL,
 brand BRAND_ENUM NOT NULL,
 rented BOOLEAN NOT NULL
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (id);


CREATE TABLE person (
 id SERIAL,
 person_number VARCHAR(500) NOT NULL,
 first_name  VARCHAR(500) NOT NULL,
 sur_name VARCHAR(500) NOT NULL,
 email VARCHAR(500) NOT NULL,
 phone VARCHAR(500)
);

ALTER TABLE person ADD CONSTRAINT PK_person PRIMARY KEY (id);


CREATE TABLE price (
 id SERIAL,
 type TYPE_ENUM NOT NULL,
 level LEVEL_ENUM,
 price VARCHAR(500) NOT NULL
);

ALTER TABLE price ADD CONSTRAINT PK_price PRIMARY KEY (id);


CREATE TABLE student (
 person_id SERIAL,
 street VARCHAR(500) NOT NULL,
 city VARCHAR(500) NOT NULL,
 zip VARCHAR(500) NOT NULL
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (person_id);


CREATE TABLE student_sibling (
 student_id SERIAL,
 student_id_0 SERIAL
);

ALTER TABLE student_sibling ADD CONSTRAINT PK_student_sibling PRIMARY KEY (student_id,student_id_0);


CREATE TABLE instructor (
 person_id SERIAL,
 ensamble BOOLEAN NOT NULL
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (person_id);


CREATE TABLE instructor_teach_instrument (
 instructor_id SERIAL,
 level  LEVEL_ENUM NOT NULL,
 instrument INSTRUMENT_ENUM NOT NULL
);

ALTER TABLE instructor_teach_instrument ADD CONSTRAINT PK_instructor_teach_instrument PRIMARY KEY (instructor_id);


CREATE TABLE lesson (
 id SERIAL,
 date_and_time TIMESTAMP(6) NOT NULL,
 instructor_id SERIAL,
 price_id SERIAL,
 place CHAR(10)
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (id);


CREATE TABLE rent_instrument (
 instrument_id SERIAL ,
 fee VARCHAR(500) NOT NULL,
 start_at DATE NOT NULL,
 end_at DATE NOT NULL,
 person_id SERIAL
);

ALTER TABLE rent_instrument ADD CONSTRAINT PK_rent_instrument PRIMARY KEY (instrument_id);


CREATE TABLE skill_level (
 student_id SERIAL,
 instrument INSTRUMENT_ENUM NOT NULL,
 level LEVEL_ENUM NOT NULL
);

ALTER TABLE skill_level ADD CONSTRAINT PK_skill_level PRIMARY KEY (student_id);


CREATE TABLE student_lesson (
 lesson_id SERIAL ,
 student_id SERIAL 
);

ALTER TABLE student_lesson ADD CONSTRAINT PK_student_lesson PRIMARY KEY (lesson_id,student_id);


CREATE TABLE ensamble (
 lesson_id SERIAL ,
 target_genre GENGRE_ENUM NOT NULL,
 min_participants VARCHAR(500) NOT NULL,
 max_participants VARCHAR(500) NOT NULL
);

ALTER TABLE ensamble ADD CONSTRAINT PK_ensamble PRIMARY KEY (lesson_id);


CREATE TABLE group_lesson (
 lesson_id SERIAL,
 instrument ENUM NOT NULL,
 min_participants VARCHAR(500) NOT NULL,
 max_participants VARCHAR(500),
 level ENUM NOT NULL
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (lesson_id);


CREATE TABLE individual_lesson (
 lesson_id SERIAL,
 instrument ENUM
);

ALTER TABLE individual_lesson ADD CONSTRAINT PK_individual_lesson PRIMARY KEY (lesson_id);


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (person_id) REFERENCES person (id);


ALTER TABLE student_sibling ADD CONSTRAINT FK_student_sibling_0 FOREIGN KEY (student_id) REFERENCES student (person_id);
ALTER TABLE student_sibling ADD CONSTRAINT FK_student_sibling_1 FOREIGN KEY (student_id_0) REFERENCES student (person_id);


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (person_id) REFERENCES person (id);


ALTER TABLE instructor_teach_instrument ADD CONSTRAINT FK_instructor_teach_instrument_0 FOREIGN KEY (instructor_id) REFERENCES instructor (person_id);


ALTER TABLE lesson ADD CONSTRAINT FK_lesson_0 FOREIGN KEY (instructor_id) REFERENCES instructor (person_id);
ALTER TABLE lesson ADD CONSTRAINT FK_lesson_1 FOREIGN KEY (price_id) REFERENCES price (id);


ALTER TABLE rent_instrument ADD CONSTRAINT FK_rent_instrument_0 FOREIGN KEY (instrument_id) REFERENCES instrument (id);
ALTER TABLE rent_instrument ADD CONSTRAINT FK_rent_instrument_1 FOREIGN KEY (person_id) REFERENCES student (person_id);


ALTER TABLE skill_level ADD CONSTRAINT FK_skill_level_0 FOREIGN KEY (student_id) REFERENCES student (person_id);


ALTER TABLE student_lesson ADD CONSTRAINT FK_student_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id);
ALTER TABLE student_lesson ADD CONSTRAINT FK_student_lesson_1 FOREIGN KEY (student_id) REFERENCES student (person_id);


ALTER TABLE ensamble ADD CONSTRAINT FK_ensamble_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id);


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id);


ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id);


