CREATE TABLE instrument (
 instrument_id SERIAL,
 instrument VARCHAR(500) NOT NULL,
 brand VARCHAR(500) NOT NULL,
 rented BOOLEAN NOT NULL
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (instrument_id);


CREATE TABLE learn_instrument (
 id SERIAL,
 instrument VARCHAR(500) NOT NULL
);

ALTER TABLE learn_instrument ADD CONSTRAINT PK_learn_instrument PRIMARY KEY (id);


CREATE TABLE person (
 person_id SERIAL,
 person_number VARCHAR(500) NOT NULL,
 first_name  VARCHAR(500) NOT NULL,
 sur_name VARCHAR(500) NOT NULL,
 email VARCHAR(500) NOT NULL,
 street VARCHAR(500) NOT NULL,
 city VARCHAR(500) NOT NULL,
 zip VARCHAR(500) NOT NULL
);

ALTER TABLE person ADD CONSTRAINT PK_person PRIMARY KEY (person_id);


CREATE TABLE phone (
 id  SERIAL,
 phone_num VARCHAR(500) NOT NULL
);

ALTER TABLE phone ADD CONSTRAINT PK_phone PRIMARY KEY (id );


CREATE TABLE price (
 id SERIAL,
 type VARCHAR(500) NOT NULL,
 level VARCHAR(500),
 price VARCHAR(500) NOT NULL
);

ALTER TABLE price ADD CONSTRAINT PK_price PRIMARY KEY (id);


CREATE TABLE student (
 person_id SERIAL,
 contact_person VARCHAR(500)
)INHERITS (person);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (person_id);


CREATE TABLE student_learn_instrument (
 play_instrument_id SERIAL,
 person_id SERIAL
);

ALTER TABLE student_learn_instrument ADD CONSTRAINT PK_student_learn_instrument PRIMARY KEY (play_instrument_id,person_id);


CREATE TABLE student_sibling (
 person_id SERIAL,
 person_id_0 SERIAL
);

ALTER TABLE student_sibling ADD CONSTRAINT PK_student_sibling PRIMARY KEY (person_id,person_id_0);


CREATE TABLE teach_instrument (
 id SERIAL,
 instrument VARCHAR(500) NOT NULL
);

ALTER TABLE teach_instrument ADD CONSTRAINT PK_teach_instrument PRIMARY KEY (id);


CREATE TABLE contact_person (
 contact_person_id SERIAL,
 student_id SERIAL)
 INHERITS (person);

ALTER TABLE contact_person ADD CONSTRAINT PK_contact_person PRIMARY KEY (contact_person_id, student_id);


CREATE TABLE instructor (
 person_id SERIAL,
 ensamble VARCHAR(500) NOT NULL
)INHERITS (person);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (person_id);


CREATE TABLE instructor_teach_instrument (
 instructor_id SERIAL,
 teach_instrument_id SERIAL NOT NULL
);

ALTER TABLE instructor_teach_instrument ADD CONSTRAINT PK_instructor_teach_instrument PRIMARY KEY (instructor_id,teach_instrument_id);


CREATE TABLE lesson (
 lesson_id SERIAL,
 date_and_time CHAR(500),
 instructor_person_id SERIAL,
 price_id SERIAL,
 place CHAR(500)
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (lesson_id);


CREATE TABLE person_phone (
 person_id SERIAL,
 phone_id SERIAL
);

ALTER TABLE person_phone ADD CONSTRAINT PK_person_phone PRIMARY KEY (person_id,phone_id);


CREATE TABLE rent_instrument (
 instrument_id SERIAL,
 fee VARCHAR(500) NOT NULL,
 start_at DATE NOT NULL,
 end_at DATE NOT NULL,
 person_id SERIAL
);

ALTER TABLE rent_instrument ADD CONSTRAINT PK_rent_instrument PRIMARY KEY (instrument_id );


CREATE TABLE skill_level (
 person_id SERIAL,
 instrument VARCHAR(500) NOT NULL,
 skill_level VARCHAR(500) NOT NULL
);

ALTER TABLE skill_level ADD CONSTRAINT PK_skill_level PRIMARY KEY (person_id);


CREATE TABLE student_lesson (
 lesson_id SERIAL,
 person_id SERIAL
);

ALTER TABLE student_lesson ADD CONSTRAINT PK_student_lesson PRIMARY KEY (lesson_id,person_id);


CREATE TABLE ensamble (
 lesson_id SERIAL,
 target_genre VARCHAR(500) NOT NULL,
 min_participants VARCHAR(10) NOT NULL,
 max_participants VARCHAR(10) NOT NULL
)INHERITS (lesson);

ALTER TABLE ensamble ADD CONSTRAINT PK_ensamble PRIMARY KEY (lesson_id);


CREATE TABLE group_lesson (
 lesson_id SERIAL ,
 instrument VARCHAR(500) NOT NULL,
 min_participants VARCHAR(500) NOT NULL,
 max_participants VARCHAR(500),
 level VARCHAR(500) NOT NULL
)INHERITS (lesson);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (lesson_id);


CREATE TABLE individual_lesson (
  lesson_id SERIAL
)INHERITS (lesson);

ALTER TABLE individual_lesson ADD CONSTRAINT PK_individual_lesson PRIMARY KEY (lesson_id);


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (person_id) REFERENCES person (person_id);


ALTER TABLE student_learn_instrument ADD CONSTRAINT FK_student_learn_instrument_0 FOREIGN KEY (play_instrument_id) REFERENCES learn_instrument (id);
ALTER TABLE student_learn_instrument ADD CONSTRAINT FK_student_learn_instrument_1 FOREIGN KEY (person_id) REFERENCES student (person_id);


ALTER TABLE student_sibling ADD CONSTRAINT FK_student_sibling_0 FOREIGN KEY (person_id) REFERENCES student (person_id);
ALTER TABLE student_sibling ADD CONSTRAINT FK_student_sibling_1 FOREIGN KEY (person_id_0) REFERENCES student (person_id);


ALTER TABLE contact_person ADD CONSTRAINT FK_contact_person_0 FOREIGN KEY (contact_person_id) REFERENCES person (person_id);
ALTER TABLE contact_person ADD CONSTRAINT FK_contact_person_1 FOREIGN KEY (student_id) REFERENCES student (person_id);


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (person_id) REFERENCES person (person_id);


ALTER TABLE instructor_teach_instrument ADD CONSTRAINT FK_instructor_teach_instrument_0 FOREIGN KEY (instructor_id) REFERENCES instructor (person_id);
ALTER TABLE instructor_teach_instrument ADD CONSTRAINT FK_instructor_teach_instrument_1 FOREIGN KEY (teach_instrument_id) REFERENCES teach_instrument (id);


ALTER TABLE lesson ADD CONSTRAINT FK_lesson_0 FOREIGN KEY (instructor_person_id) REFERENCES instructor (person_id);
ALTER TABLE lesson ADD CONSTRAINT FK_lesson_1 FOREIGN KEY (price_id) REFERENCES price (id);


ALTER TABLE person_phone ADD CONSTRAINT FK_person_phone_0 FOREIGN KEY (person_id) REFERENCES person (person_id);
ALTER TABLE person_phone ADD CONSTRAINT FK_person_phone_1 FOREIGN KEY (phone_id) REFERENCES phone (id );


ALTER TABLE rent_instrument ADD CONSTRAINT FK_rent_instrument_0 FOREIGN KEY (instrument_id) REFERENCES instrument ( instrument_id);
ALTER TABLE rent_instrument ADD CONSTRAINT FK_rent_instrument_1 FOREIGN KEY (person_id) REFERENCES student (person_id);


ALTER TABLE skill_level ADD CONSTRAINT FK_skill_level_0 FOREIGN KEY (person_id) REFERENCES student (person_id);


ALTER TABLE student_lesson ADD CONSTRAINT FK_student_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);
ALTER TABLE student_lesson ADD CONSTRAINT FK_student_lesson_1 FOREIGN KEY (person_id) REFERENCES student (person_id);


ALTER TABLE ensamble ADD CONSTRAINT FK_ensamble_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);


ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);


