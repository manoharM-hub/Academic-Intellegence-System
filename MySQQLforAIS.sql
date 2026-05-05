SET SQL_SAFE_UPDATES = 0;

DROP DATABASE IF EXISTS student_portal;
CREATE DATABASE student_portal;
USE student_portal;

-- Line 12  - Query, to create mentor table --------------------------------------
-- Line 28  - Query, to create mentor_students table ----------------------------
-- Line 52  - Query, to create parent_messages table ----------------------------
-- Line 68  - Query, to create students table ------------------------------------
-- Line 118 - Query, to create student_results table ----------------------------
-- Line 310 - Query, to create student_attendance table -------------------------
-- Line 318 - Query for fetching chats -------------------------------------------
-- Line 322 - Query for fetching complaints --------------------------------------
-- Line 401 - Query to create student_unit_marks ---------------------------------
-- Line 428 - Query for name update ----------------------------------------------
-- ======================
-- MENTOR TABLE
-- ======================
CREATE TABLE mentors(
id VARCHAR(20) PRIMARY KEY,
name VARCHAR(50),
password VARCHAR(50)
);

INSERT INTO mentors VALUES
('TTS01','Dr. Lordwin C','01010000'),
('TTS02','Dr. Remya R','01010000');

ALTER TABLE mentors ADD designation VARCHAR(50);
ALTER TABLE mentors ADD department VARCHAR(50);

UPDATE mentors SET designation = 'Professor', department = 'ECE' WHERE id = 'TTS01';
UPDATE mentors SET designation = 'Assistant Professor', department = 'ECE' WHERE id = 'TTS02';

-- ======================
-- MENTOR STUDENTS TABLE
-- ======================
CREATE TABLE mentor_students(
mentor_id VARCHAR(20),
student_id VARCHAR(20)
);

INSERT INTO mentor_students VALUES
('TTS01','VTU21832'),
('TTS01','VTU23099'),
('TTS02','VTU22807'),
('TTS02','VTU22749');

-- ======================
-- PARENT MESSAGES TABLE
-- ======================
CREATE TABLE parent_messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(20),
    mentor_id VARCHAR(20),
    parent_id VARCHAR(20),
    sender_role VARCHAR(20),
    subject VARCHAR(100),
    message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ======================
-- STUDENTS TABLE
-- ======================
CREATE TABLE students(
id VARCHAR(20) PRIMARY KEY,
name VARCHAR(50),
password VARCHAR(50),
roll VARCHAR(20),
gender VARCHAR(10),
father VARCHAR(50),
mother VARCHAR(50),
dob VARCHAR(20),
degree VARCHAR(50),
branch VARCHAR(100),
community VARCHAR(20),
religion VARCHAR(20),
nationality VARCHAR(20),
aadhaar VARCHAR(20),
mobile VARCHAR(20)
);

INSERT INTO students VALUES
('VTU21832','Manohar','22062004','22UEEC0194','Male','MUDRAGADA RANGAIAH','MUDRAGADA SAMPURNA','22/06/2004','B.Tech','Electronics & Communication Engineering','OC','Hinduism','Indian','597351294196','9989178162'),
('VTU22807','Manoj','26062005','22UEEC0114','Male','INDLA MALYADRI','INDLA SRI LAKSHMI','26/06/2005','B.Tech','Electronics & Communication Engineering','OC','Hinduism','Indian','491985437749','9949292635'),
('VTU22749','Yetukuri Annaiah','15092003','22UEEC0322','Male','YETUKURI NAGESWARA','','15/09/2003','B.Tech','Electronics & Communication Engineering','OC','Hinduism','Indian','','9030084322');

INSERT INTO students
(id,name,password,roll,gender,father,mother,dob,degree,branch,community,religion,nationality,aadhaar,mobile)
VALUES
('VTU23099','P S DINESH KUMAR','28062005','22UEEA0059','Male','P SUDHAKAR','','28/06/2005','B.Tech','Electronics & Communication Engineering (AIDS)','OBC','Hinduism','Indian','','7673957325');

-- ======================
-- STUDENT RESULTS TABLE
-- ======================
CREATE TABLE student_results(
id VARCHAR(20),
semester INT,
course_code VARCHAR(20),
course_name VARCHAR(100),
result VARCHAR(10),
grade VARCHAR(5)
);

-- SEM 1 - VTU21832
INSERT INTO student_results VALUES
('VTU21832',1,'10210CH101','Engineering Chemistry','Pass','B'),
('VTU21832',1,'10210CH301','Engineering Chemistry Laboratory','Pass','S'),
('VTU21832',1,'10210CS101','Problem Solving using C','Pass','A'),
('VTU21832',1,'10210CS301','Problem Solving using C Laboratory','Pass','S'),
('VTU21832',1,'10210EE301','Engineering Products Laboratory','Pass','S'),
('VTU21832',1,'10210EN201','Professional Communication - I','Pass','C'),
('VTU21832',1,'10210MA201','Matrices and Calculus','Pass','B'),
('VTU21832',1,'10210ME101','Design Thinking','Pass','S'),
('VTU21832',1,'10210ME201','Engineering Graphics','Pass','S'),
('VTU21832',1,'10210PH102','Physics of Materials','Pass','A');

-- SEM 2 - VTU21832
INSERT INTO student_results VALUES
('VTU21832',2,'10210BM101','Biology for Engineers','Pass','A'),
('VTU21832',2,'10210CS201','Python Programming','Pass','B'),
('VTU21832',2,'10210EE202','Basic Electrical & Instrumentation Engineering','Pass','C'),
('VTU21832',2,'10210EE204','Introduction to Engineering','Pass','S'),
('VTU21832',2,'10210EN202','Professional Communication - II','Pass','B'),
('VTU21832',2,'10210MA203','Vector Calculus and Complex Variables','Pass','B'),
('VTU21832',2,'10210ME102','Universal Human Values','Pass','S'),
('VTU21832',2,'10210PH103','Applied Physics','Pass','S'),
('VTU21832',2,'10210PH302','Applied Physics Laboratory','Pass','A'),
('VTU21832',2,'10217GE901','Engineers and Society','Pass','S'),
('VTU21832',2,'10217GE902','Constitution of India','Pass','A');

-- SEM 3 - VTU21832
INSERT INTO student_results VALUES
('VTU21832',3,'10210MA104','Fourier Series and Transform Techniques','Pass','A'),
('VTU21832',3,'10211EC101','Circuit Theory','Pass','B'),
('VTU21832',3,'10211EC102','Analog Electronics','Pass','S'),
('VTU21832',3,'10211EC103','Digital Electronics','Pass','A'),
('VTU21832',3,'10211EC104','Linear Integrated Circuits','Pass','S'),
('VTU21832',3,'10211EC110','Data Communication Networks','Pass','A'),
('VTU21832',3,'10211EC301','Analog Integrated Circuits Laboratory','Pass','S'),
('VTU21832',3,'10211EC302','Digital Electronics Laboratory','Pass','A'),
('VTU21832',3,'10213CS102','Data Structures','Pass','A'),
('VTU21832',3,'10216GE901','Soft Skills - I','Pass','D');

-- SEM 4 - VTU21832
INSERT INTO student_results VALUES
('VTU21832',4,'10210MA106','Probability and Random Processes','Pass','A'),
('VTU21832',4,'10211EC106','Signals and Systems','Pass','B'),
('VTU21832',4,'10211EC107','Electromagnetics and Transmission Lines','Pass','A'),
('VTU21832',4,'10211EC108','Communication Systems','Pass','B'),
('VTU21832',4,'10211EC109','Microprocessor and Microcontroller','Pass','A'),
('VTU21832',4,'10211EC304','Microprocessor and Microcontroller Laboratory','Pass','A'),
('VTU21832',4,'10211EC305','Communication Laboratory','Pass','A'),
('VTU21832',4,'10212EC130','Solid State Devices','Pass','B'),
('VTU21832',4,'10213CS103','Operating Systems','Pass','S'),
('VTU21832',4,'10216GE902','Soft Skills - II','Pass','C');

-- SEM 5 - VTU21832
INSERT INTO student_results VALUES
('VTU21832',5,'10210ME103','Innovation and Entrepreneurship','Pass','C'),
('VTU21832',5,'10210ME104','Project Management and Finance','Pass','A'),
('VTU21832',5,'10211EC111','Discrete Time Signal Processing','Pass','B'),
('VTU21832',5,'10211EC112','Wireless Communication','Pass','A'),
('VTU21832',5,'10211EC113','Antenna Theory','Pass','B'),
('VTU21832',5,'10211EC114','VLSI Design','Pass','A'),
('VTU21832',5,'10211EC303','Signal Processing Laboratory','Pass','S'),
('VTU21832',5,'10212EC102','Cellular Mobile Communication','Pass','S'),
('VTU21832',5,'10213CE401','Municipal Solid Waste Management','Pass','B'),
('VTU21832',5,'10214EC501','Community Service Project','Pass','A'),
('VTU21832',5,'10215EC802','In-plant Training - II','Pass','S'),
('VTU21832',5,'10215EC927','Gamification in Health Care','Pass','S'),
('VTU21832',5,'10216GE903','Aptitude Skills - I','Pass','B');

-- SEM 1 - VTU22807
INSERT INTO student_results VALUES
('VTU22807',1,'10210CH101','Engineering Chemistry','Pass','D'),
('VTU22807',1,'10210CH301','Engineering Chemistry Laboratory','Pass','A'),
('VTU22807',1,'10210CS101','Problem Solving using C','Pass','C'),
('VTU22807',1,'10210CS301','Problem Solving using C Laboratory','Pass','S'),
('VTU22807',1,'10210EE301','Engineering Products Laboratory','Pass','A'),
('VTU22807',1,'10210EN201','Professional Communication - I','Pass','C'),
('VTU22807',1,'10210MA201','Matrices and Calculus','Pass','D'),
('VTU22807',1,'10210ME101','Design Thinking','Pass','A'),
('VTU22807',1,'10210ME201','Engineering Graphics','Pass','B'),
('VTU22807',1,'10210PH102','Physics of Materials','Pass','B');

-- SEM 2 - VTU22807
INSERT INTO student_results VALUES
('VTU22807',2,'10210BM101','Biology for Engineers','Pass','C'),
('VTU22807',2,'10210CS201','Python Programming','Pass','B'),
('VTU22807',2,'10210EE202','Basic Electrical & Instrumentation Engineering','Pass','C'),
('VTU22807',2,'10210EE204','Introduction to Engineering','Pass','S'),
('VTU22807',2,'10210EN202','Professional Communication - II','Pass','B'),
('VTU22807',2,'10210MA203','Vector Calculus and Complex Variables','Pass','D'),
('VTU22807',2,'10210ME102','Universal Human Values','Pass','B'),
('VTU22807',2,'10210PH103','Applied Physics','Pass','C'),
('VTU22807',2,'10210PH302','Applied Physics Laboratory','Pass','A'),
('VTU22807',2,'10217GE901','Engineers and Society','Pass','S'),
('VTU22807',2,'10217GE902','Constitution of India','Pass','C');

-- SEM 3 - VTU22807
INSERT INTO student_results VALUES
('VTU22807',3,'10210MA104','Fourier Series and Transform Techniques','Pass','B'),
('VTU22807',3,'10211EC101','Circuit Theory','Pass','C'),
('VTU22807',3,'10211EC102','Analog Electronics','Pass','B'),
('VTU22807',3,'10211EC103','Digital Electronics','Pass','C'),
('VTU22807',3,'10211EC104','Linear Integrated Circuits','Pass','B'),
('VTU22807',3,'10211EC110','Data Communication Networks','Pass','B'),
('VTU22807',3,'10211EC301','Analog Integrated Circuits Laboratory','Pass','S'),
('VTU22807',3,'10211EC302','Digital Electronics Laboratory','Pass','S'),
('VTU22807',3,'10213CS102','Data Structures','Pass','C'),
('VTU22807',3,'10216GE901','Soft Skills - I','Pass','C');

-- SEM 4 - VTU22807
INSERT INTO student_results VALUES
('VTU22807',4,'10210MA106','Probability and Random Processes','Pass','C'),
('VTU22807',4,'10211EC106','Signals and Systems','Pass','C'),
('VTU22807',4,'10211EC107','Electromagnetics and Transmission Lines','Pass','C'),
('VTU22807',4,'10211EC108','Communication Systems','Pass','C'),
('VTU22807',4,'10211EC109','Microprocessor and Microcontroller','Pass','A'),
('VTU22807',4,'10211EC304','Microprocessor and Microcontroller Laboratory','Pass','A'),
('VTU22807',4,'10211EC305','Communication Laboratory','Pass','S'),
('VTU22807',4,'10212EC130','Solid State Devices','Pass','C'),
('VTU22807',4,'10213CS103','Operating Systems','Pass','A'),
('VTU22807',4,'10216GE902','Soft Skills - II','Pass','B');

-- SEM 5 - VTU22807
INSERT INTO student_results VALUES
('VTU22807',5,'10210ME103','Innovation and Entrepreneurship','Pass','A'),
('VTU22807',5,'10210ME104','Project Management and Finance','Pass','S'),
('VTU22807',5,'10211EC111','Discrete Time Signal Processing','Pass','C'),
('VTU22807',5,'10211EC112','Wireless Communication','Pass','C'),
('VTU22807',5,'10211EC113','Antenna Theory','Pass','C'),
('VTU22807',5,'10211EC114','VLSI Design','Pass','C'),
('VTU22807',5,'10211EC303','Signal Processing Laboratory','Pass','S'),
('VTU22807',5,'10212EC102','Cellular Mobile Communication','Pass','A'),
('VTU22807',5,'10214EC501','Community Service Project','Pass','A'),
('VTU22807',5,'10215EC802','In-plant Training - II','Pass','A'),
('VTU22807',5,'10215EC927','Gamification in Health Care','Pass','S'),
('VTU22807',5,'10216GE903','Aptitude Skills - I','Pass','C');

-- SEM 1 - VTU22749
INSERT INTO student_results VALUES
('VTU22749',1,'10210CH101','Engineering Chemistry','Pass','C'),
('VTU22749',1,'10210CH301','Engineering Chemistry Laboratory','Pass','S'),
('VTU22749',1,'10210CS101','Problem Solving using C','Pass','C'),
('VTU22749',1,'10210CS301','Problem Solving using C Laboratory','Pass','A'),
('VTU22749',1,'10210EE301','Engineering Products Laboratory','Pass','S'),
('VTU22749',1,'10210EN201','Professional Communication - I','Pass','C'),
('VTU22749',1,'10210MA201','Matrices and Calculus','Pass','B'),
('VTU22749',1,'10210ME101','Design Thinking','Pass','A'),
('VTU22749',1,'10210ME201','Engineering Graphics','Pass','A'),
('VTU22749',1,'10210PH102','Physics of Materials','Pass','A');

-- SEM 2 - VTU22749
INSERT INTO student_results VALUES
('VTU22749',2,'10210BM101','Biology for Engineers','Pass','B'),
('VTU22749',2,'10210CS201','Python Programming','Pass','C'),
('VTU22749',2,'10210EE202','Basic Electrical & Instrumentation Engineering','Pass','C'),
('VTU22749',2,'10210EE204','Introduction to Engineering','Pass','S'),
('VTU22749',2,'10210EN202','Professional Communication - II','Pass','C'),
('VTU22749',2,'10210MA203','Vector Calculus and Complex Variables','Pass','B'),
('VTU22749',2,'10210ME102','Universal Human Values','Pass','B'),
('VTU22749',2,'10210PH103','Applied Physics','Pass','C'),
('VTU22749',2,'10210PH302','Applied Physics Laboratory','Pass','B'),
('VTU22749',2,'10217GE901','Engineers and Society','Pass','S'),
('VTU22749',2,'10217GE902','Constitution of India','Pass','S');

-- SEM 3 - VTU22749
INSERT INTO student_results VALUES
('VTU22749',3,'10210MA104','Fourier Series and Transform Techniques','Pass','C'),
('VTU22749',3,'10211EC101','Circuit Theory','Pass','C'),
('VTU22749',3,'10211EC102','Analog Electronics','Pass','A'),
('VTU22749',3,'10211EC103','Digital Electronics','Pass','C'),
('VTU22749',3,'10211EC104','Linear Integrated Circuits','Pass','B'),
('VTU22749',3,'10211EC110','Data Communication Networks','Pass','B'),
('VTU22749',3,'10211EC301','Analog Integrated Circuits Laboratory','Pass','S'),
('VTU22749',3,'10211EC302','Digital Electronics Laboratory','Pass','S'),
('VTU22749',3,'10213CS102','Data Structures','Pass','A'),
('VTU22749',3,'10216GE901','Soft Skills - I','Pass','C');

-- SEM 4 - VTU22749
INSERT INTO student_results VALUES
('VTU22749',4,'10210MA106','Probability and Random Processes','Pass','A'),
('VTU22749',4,'10211EC106','Signals and Systems','Pass','D'),
('VTU22749',4,'10211EC107','Electromagnetics and Transmission Lines','Pass','C'),
('VTU22749',4,'10211EC108','Communication Systems','Pass','C'),
('VTU22749',4,'10211EC109','Microprocessor and Microcontroller','Pass','C'),
('VTU22749',4,'10211EC304','Microprocessor and Microcontroller Laboratory','Pass','A'),
('VTU22749',4,'10211EC305','Communication Laboratory','Pass','S'),
('VTU22749',4,'10212EC130','Solid State Devices','Pass','B'),
('VTU22749',4,'10213CS103','Operating Systems','Pass','A'),
('VTU22749',4,'10216GE902','Soft Skills - II','Pass','D');

-- SEM 5 - VTU22749
INSERT INTO student_results VALUES
('VTU22749',5,'10210ME103','Innovation and Entrepreneurship','Pass','C'),
('VTU22749',5,'10210ME104','Project Management and Finance','Pass','B'),
('VTU22749',5,'10211EC111','Discrete Time Signal Processing','Pass','C'),
('VTU22749',5,'10211EC112','Wireless Communication','Pass','C'),
('VTU22749',5,'10211EC113','Antenna Theory','Pass','C'),
('VTU22749',5,'10211EC114','VLSI Design','Pass','C'),
('VTU22749',5,'10211EC303','Signal Processing Laboratory','Pass','A'),
('VTU22749',5,'10212EC209','Software Defined Networking','Pass','C'),
('VTU22749',5,'10214EC501','Community Service Project','Pass','S'),
('VTU22749',5,'10215EC925','Radar System in Space Applications','Pass','A'),
('VTU22749',5,'10215EC930','RF Energy Harvesting Systems','Pass','S'),
('VTU22749',5,'10216GE903','Aptitude Skills - I','Pass','D');

-- SEM 1 - VTU23099
INSERT INTO student_results VALUES
('VTU23099',1,'10210CH101','Engineering Chemistry','Pass','A'),
('VTU23099',1,'10210CH301','Engineering Chemistry Laboratory','Pass','S'),
('VTU23099',1,'10210CS101','Problem Solving using C','Pass','A'),
('VTU23099',1,'10210CS301','Problem Solving using C Laboratory','Pass','S'),
('VTU23099',1,'10210EE301','Engineering Products Laboratory','Pass','S'),
('VTU23099',1,'10210EN201','Professional Communication - I','Pass','C'),
('VTU23099',1,'10210MA201','Matrices and Calculus','Pass','B'),
('VTU23099',1,'10210ME101','Design Thinking','Pass','A'),
('VTU23099',1,'10210ME201','Engineering Graphics','Pass','S'),
('VTU23099',1,'10210PH102','Physics of Materials','Pass','S');

-- SEM 2 - VTU23099
INSERT INTO student_results VALUES
('VTU23099',2,'10210BM101','Biology for Engineers','Pass','S'),
('VTU23099',2,'10210CS201','Python Programming','Pass','S'),
('VTU23099',2,'10210EE202','Basic Electrical & Instrumentation Engineering','Pass','A'),
('VTU23099',2,'10210EE204','Introduction to Engineering','Pass','S'),
('VTU23099',2,'10210EN202','Professional Communication - II','Pass','B'),
('VTU23099',2,'10210MA203','Vector Calculus and Complex Variables','Pass','S'),
('VTU23099',2,'10210ME102','Universal Human Values','Pass','B'),
('VTU23099',2,'10210PH103','Applied Physics','Pass','S'),
('VTU23099',2,'10210PH302','Applied Physics Laboratory','Pass','S'),
('VTU23099',2,'10217GE901','Engineers and Society','Pass','S'),
('VTU23099',2,'10217GE902','Constitution of India','Pass','S');

-- SEM 3 - VTU23099
INSERT INTO student_results VALUES
('VTU23099',3,'10210MA104','Fourier Series and Transform Techniques','Pass','S'),
('VTU23099',3,'10211EC101','Circuit Theory','Pass','A'),
('VTU23099',3,'10211EC102','Analog Electronics','Pass','A'),
('VTU23099',3,'10211EC103','Digital Electronics','Pass','A'),
('VTU23099',3,'10211EC104','Linear Integrated Circuits','Pass','A'),
('VTU23099',3,'10211EC110','Data Communication Networks','Pass','S'),
('VTU23099',3,'10211EC301','Analog Integrated Circuits Laboratory','Pass','S'),
('VTU23099',3,'10211EC302','Digital Electronics Laboratory','Pass','S'),
('VTU23099',3,'10213CS102','Data Structures','Pass','A'),
('VTU23099',3,'10216GE901','Soft Skills - I','Pass','A');

-- SEM 4 - VTU23099
INSERT INTO student_results VALUES
('VTU23099',4,'10210MA106','Probability and Random Processes','Pass','A'),
('VTU23099',4,'10211EC106','Signals and Systems','Pass','S'),
('VTU23099',4,'10211EC107','Electromagnetics and Transmission Lines','Pass','A'),
('VTU23099',4,'10211EC108','Communication Systems','Pass','A'),
('VTU23099',4,'10211EC109','Microprocessor and Microcontroller','Pass','A'),
('VTU23099',4,'10211EC304','Microprocessor and Microcontroller Laboratory','Pass','A'),
('VTU23099',4,'10211EC305','Communication Laboratory','Pass','S'),
('VTU23099',4,'10212EC174','Principles of Data Science','Pass','A'),
('VTU23099',4,'10213CS103','Operating Systems','Pass','A'),
('VTU23099',4,'10216GE902','Soft Skills - II','Pass','A');

-- SEM 5 - VTU23099
INSERT INTO student_results VALUES
('VTU23099',5,'10210ME103','Innovation and Entrepreneurship','Pass','A'),
('VTU23099',5,'10210ME104','Project Management and Finance','Pass','S'),
('VTU23099',5,'10211EC111','Discrete Time Signal Processing','Pass','A'),
('VTU23099',5,'10211EC112','Wireless Communication','Pass','S'),
('VTU23099',5,'10211EC113','Antenna Theory','Pass','A'),
('VTU23099',5,'10211EC114','VLSI Design','Pass','A'),
('VTU23099',5,'10211EC303','Signal Processing Laboratory','Pass','S'),
('VTU23099',5,'10212EC226','Machine Learning','Pass','A'),
('VTU23099',5,'10213CE401','Municipal Solid Waste Management','Pass','S'),
('VTU23099',5,'10214EC501','Community Service Project','Pass','A'),
('VTU23099',5,'10215EC802','In-plant Training - II','Pass','S'),
('VTU23099',5,'10215EC927','Gamification in Health Care','Pass','S'),
('VTU23099',5,'10216GE903','Aptitude Skills - I','Pass','A');

-- ======================
-- ATTENDANCE TABLE
-- ======================
CREATE TABLE student_attendance(
id VARCHAR(20),
semester INT,
course_code VARCHAR(20),
course_name VARCHAR(100),
total_hours INT,
present_hours INT,
absent_hours INT
);
DROP TABLE student_attendance;
INSERT INTO student_attendance VALUES
('VTU21832',1,'10210CS101','Problem Solving using C',40,32,8),
('VTU21832',1,'10210MA201','Matrices and Calculus',45,35,10),
('VTU21832',1,'10210PH102','Physics of Materials',42,30,12),
('VTU21832',8,'10214EC701','Major Project',75,40,25);
desc student_attendance;
-- to fetch chats -------------------------------------------------
USE student_portal;
SELECT * FROM parent_messages ORDER BY created_at DESC;

-- to fetch complaints --------------------------------------------
USE student_portal;
SELECT * FROM parent_messages 
WHERE subject LIKE '%Complaint%' 
AND sender_role = 'mentor'
ORDER BY created_at DESC;

-- UNIT MARKS TABLE--------------------------------------------------------------------------------

CREATE TABLE student_unit_marks(
id VARCHAR(20),
semester INT,
course_code VARCHAR(20),
course_name VARCHAR(100),
unit1 INT,
unit2 INT,
unit3 INT
);
drop table student_unit_marks;
desc student_unit_marks;
-- VTU21832 Semester 1 Unit Marks
INSERT INTO student_unit_marks VALUES
('VTU21832',1,'10210CH101','Engineering Chemistry',18,17,24),
('VTU21832',1,'10210CH301','Engineering Chemistry Laboratory',20,20,25),
('VTU21832',1,'10210CS101','Problem Solving using C',19,18,23),
('VTU21832',1,'10210CS301','Problem Solving using C Laboratory',20,20,25),
('VTU21832',1,'10210EE301','Engineering Products Laboratory',20,19,24),
('VTU21832',1,'10210EN201','Professional Communication - I',16,15,20),
('VTU21832',1,'10210MA201','Matrices and Calculus',17,18,22),
('VTU21832',1,'10210ME101','Design Thinking',20,20,25),
('VTU21832',1,'10210ME201','Engineering Graphics',19,20,24),
('VTU21832',1,'10210PH102','Physics of Materials',18,19,23);

-- to update names---------------------------------------------------------------------------------------
UPDATE students
SET name = 'Mudragada Manohar'
WHERE id = 'VTU21832';
use student_portal;
SELECT * FROM student_attendance WHERE id='VTU21832';
SELECT * FROM student_attendance WHERE id='VTU21832';SELECT * FROM student_attendance WHERE id='VTU21832';
TRUNCATE TABLE student_attendance;

-- Resume Query ---------------------------------------------------------------------------------------
USE student_portal;
ALTER TABLE students ADD resume_file VARCHAR(100);
desc students;
SELECT id, name, resume_file 
FROM students;


USE student_portal;

CREATE TABLE events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    mentor_id VARCHAR(20),
    title VARCHAR(200),
    description TEXT,
    event_date VARCHAR(50),
    event_time VARCHAR(50),
    venue VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- Run this in your MySQL database (phpMyAdmin or MySQL Workbench)

CREATE TABLE IF NOT EXISTS events (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  mentor_id   VARCHAR(50)   NOT NULL,
  title       VARCHAR(255)  NOT NULL,
  description TEXT,
  event_date  DATE,
  event_time  TIME,
  venue       VARCHAR(255),
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
drop table events;