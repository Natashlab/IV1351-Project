INSERT INTO instructor (first_name, sur_name, email, ensemble, person_number, street, city, zip, phone) 
VALUES 
('Sherilyn', 'Wyborn', 'swyborn0@skyrock.com', 'Punk Rock', '9396784540', '5 Eggendart Road', 'Kalibo (poblacion)', '180.175.216.39', '233-178-5923'),
('Diahann', 'Gowenlock', 'dgowenlock1@sohu.com', 'Gospel Band|Punk Rock', '8284003589', '22193 Schmedeman Plaza', 'Logroño', '138.54.190.10', '919-289-1462'),
('Janaye', 'Hawkes', 'jhawkes2@archive.org', 'Punk Rock', '5615082844', '5832 Westerfield Center', 'Xiantang', '156.226.49.148', '299-792-8230'),
('Scarlett', 'Scarffe', 'sscarffe3@devhub.com', 'Punk Rock', '7405959601', '6543 John Wall Park', 'Ljungskile', '90.104.158.241', '316-893-7883'),
('Julie', 'MacLeese', 'jmacleese4@nps.gov', 'Gospel Band', '9684641419', '74 Jackson Hill', 'Saparbay', '13.27.151.184', '968-904-0233');

INSERT INTO instrument (instrument, brand, rented) 
VALUES 
('guitar', 'Gretsch', true),
('fiol', 'Yamaha', true),
('piano', 'Boss', false),
('cello', 'Ibanez', true),
('guitar', 'Gretsch', true);

INSERT INTO learn_instrument (instrument) 
VALUES 
('guitar'),
('fiol'),
('gitar'),
('piano'),
('cello');

INSERT INTO price (type, level, price) 
VALUES
('group', 'beginner', '$35'),
('group', 'beginner', '$35'),
('individual', 'advanced', '$40'),
('individual', 'beginner', '$30'),
('group', 'advanced', '$39');

INSERT INTO student (first_name, sur_name, email, person_number, street, city, zip, phone) 
VALUES
('Corri', 'Iacomini', 'ciacomini0@vimeo.com', '5387563886', '92237 Dorton Avenue', 'Altkirch', '68134 CEDEX', '922-617-5875'),
('Roscoe', 'Riding', 'rriding1@globo.com', '4831024317', '2693 Russell Park', 'Panxi', '453703', '702-299-7822'),
('Niels', 'Janouch', 'njanouch2@nydailynews.com', '1755080875', '113 Grasskamp Place', 'Sam Phran', '73110', '514-566-8341'),
('Mandel', 'Barstow', 'mbarstow3@columbia.edu', '2152927524', '69 Bartelt Crossing', 'Illushi', '96-232', '744-171-4098'),
('Sibyl', 'Marcus', 'smarcus4@wikispaces.com', '9719660368', '94 Anniversary Way', 'Zwolle', '8024', '113-203-0859');


INSERT INTO student_learn_instrument (play_instrument_id, student_id) 
VALUES
(1, 3),
(3, 2),
(3, 5),
(2, 2),
(2, 1);

INSERT INTO student_sibling (student_id, student_id) 
VALUES
(1, 1),
(4, 2),
(3, 2),
(1, 4),
(2, 1);

INSERT INTO contact_person (first_name, email, person_number, street, zip, surname, city, phone, student_id) 
VALUES
('Eryn', 'eleyburn0@youku.com', '3894907428', '51808 Buena Vista Terrace', '67165 CEDEX', 'Pittson', 'Wissembourg', '593-104-3871', 1),
('Tedman', 'tcarsey1@biglobe.ne.jp', '7528422479', '6 Spenser Avenue', '63140', 'Rickasse', 'Mae Ramat', '345-105-3939', 4),
('Estele', 'ekenford2@parallels.com', '8087650816', '216 Morrow Crossing', '31403 CEDEX 9', 'Crandon', 'Toulouse', '973-190-8700', 3),
('Jacquelin', 'jbeynon3@wordpress.com', '9137162810', '470 Kipling Trail', '62259 CEDEX', 'Brundale', 'Verkhniy Yasenov', '217-401-4422', 2),
('Anton', 'aappleby4@boston.com', '5561823949', '2 Oriole Court', '62259 CEDEX', 'Thynn', 'Hongqi', '687-671-6194', 5);


INSERT INTO teach_instrument (instrument) 
VALUES
('piano'),
('clarinet'),
('double bass'),
('violin'),
('trumpet');

INSERT INTO ensamble (place, target_genre, min_participants, max_participants, date, time, instructor_id, price_id) 
VALUES
('303', 'Punk Rock', '10', '30', '2022-11-23' '13:15:00', 2, 3),
('303', 'Punk Rock', '10', '30', '2022-12-06' '08:00:00', 3, 1),
('304', 'Gospel', '15', '25', '2022-11-28', '12:45:00', 4, 1),
('304', 'Gospel', '15', '25', '2022-11-27, 12:30:00', 3, 2),
('304', 'Gospel', '15', '25', '2022-11-28', '09:00:00', 2, 1);

INSERT INTO group_lesson (instrument, min_participants, max_participants, level, date, time, place, price_id, instructor_id) 
VALUES
('piano', '10', '30', 'advanced', '2022-11-22' '13:00:00', '302', 2, 3),
('double bass', '10', '30', 'intermediate', '2022-12-07' '12:00:00', '201', 3, 1),
('violin', '15', '25', 'beginner', '2022-11-28', '15:45:00', '305', 4, 1),
('piano', '15', '25', 'advanced', '2022-11-30, 12:30:00', '300', 3, 2),
('trumpet', '15', '25', 'beginner', '2022-11-28', '09:00:00', '201', 2, 1);

INSERT INTO instructor_teach_instrument (teach_instrument, instructor_id, level) 
VALUES
(3, 4, 'beginner'),
(2, 4, 'intermediate'),
(1, 2, 'beginner'),
(5, 4, 'advanced'),
(1, 3, 'advanced');

INSERT INTO rent_instrument (instrument_id, fee, start_at, end_at, student_id) 
VALUES
(3, '$35', '11:00:00', '12:00:00', 3),
(2, '$40', '08:00:00', '09:00:00', 1),
(1, '$40', '08:00:00', '09:00:00', 4),
(5, '$35', '15:00:00', '16:00:00', 2),
(4, '$39', '13:00:00', '14:00:00', 5);

INSERT INTO skill_level (student_id, instrument, skill_level) 
VALUES
(2, 'piano', 'beginner'),
(5, 'clarinet', 'intermediate'),
(1, 'double bass', 'beginner'),
(4, 'violin', 'advanced'),
(3, 'trumpet', 'advanced');

INSERT INTO student_ensamble (student_id, group_lesson_id) 
VALUES
(1, 3),
(5, 2),
(3, 2),
(3, 4),
(2, 1);

INSERT INTO student_group_lesson (student_id, group_lesson_id) 
VALUES
(1, 3),
(4, 2),
(3, 2),
(3, 2),
(2, 1);

INSERT INTO individual_lesson (date, time, student_id, price_id, place, teach_instrument_id, instructor_id) 
VALUES
('11:00:00', '12:00:00', 2, 4, '307', 2, 4),
('08:00:00', '09:00:00', 1, 3, '304', 1, 1),
('08:00:00', '09:00:00', 4, 2, '304', 2, 3),
('15:00:00', '16:00:00', 5, 3, '304', 1, 1),
('13:00:00', '14:00:00', 1, 3, '304', 5, 3);


