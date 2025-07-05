CREATE DATABASE IF NOT EXISTS healthmetrics;
USE healthmetrics;

-- Verify LOCAL INFILE support (should be ON)
SHOW VARIABLES LIKE 'local_infile';

-- Disable safe updates to allow inserts and updates
SET SQL_SAFE_UPDATES = 0;

-- Drop existing tables if rerunning (in correct order to avoid FK constraint issues)
DROP TABLE IF EXISTS HealthMetrics;
DROP TABLE IF EXISTS Person;
DROP TABLE IF EXISTS Sleep_Disorder;
DROP TABLE IF EXISTS BMI;
DROP TABLE IF EXISTS temp_import;

-- Staging table for CSV import
CREATE TABLE temp_import (
    person_id INT,
    gender ENUM('Male', 'Female'),
    age INT,
    occupation VARCHAR(100),
    sleep_duration FLOAT,
    sleep_quality TINYINT,
    activity_minutes INT,
    stress_level TINYINT,
    bmi_category VARCHAR(50),
    blood_pressure VARCHAR(20),
    heart_rate INT,
    daily_steps INT,
    sleep_disorder VARCHAR(50)
);

-- BMI category lookup
CREATE TABLE BMI (
    id INT PRIMARY KEY AUTO_INCREMENT,
    category VARCHAR(50) NOT NULL UNIQUE
);

-- Sleep disorder lookup
CREATE TABLE Sleep_Disorder (
    id INT PRIMARY KEY AUTO_INCREMENT,
    disorder VARCHAR(50) NOT NULL UNIQUE
);

-- Person table
CREATE TABLE Person (
    person_id INT PRIMARY KEY AUTO_INCREMENT,
    gender ENUM('Male', 'Female') NOT NULL,
    age INT NOT NULL,
    occupation VARCHAR(100),
    bmi_category_id INT,
    sleep_disorder_id INT,
    FOREIGN KEY (bmi_category_id) REFERENCES BMI(id),
    FOREIGN KEY (sleep_disorder_id) REFERENCES Sleep_Disorder(id)
);

-- Health metrics table
CREATE TABLE HealthMetrics (
    metric_id INT PRIMARY KEY AUTO_INCREMENT,
    person_id INT NOT NULL,
    date_recorded DATE NOT NULL,
    sleep_duration FLOAT,
    sleep_quality TINYINT,
    activity_minutes INT,
    stress_level TINYINT,
    blood_pressure_sys INT,
    blood_pressure_dia INT,
    heart_rate INT,
    daily_steps INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (person_id) REFERENCES Person(person_id)
);

-- Insert sample data into temp_import table

INSERT INTO temp_import (person_id, gender, age, occupation, sleep_duration, sleep_quality, activity_minutes, stress_level, bmi_category, blood_pressure, heart_rate, daily_steps, sleep_disorder) VALUES
(1, 'Male', 27, 'Software Engineer', 6.1, 6, 42, 6, 'Overweight', '126/83', 77, 4200, 'None'),
(2, 'Male', 28, 'Doctor', 6.2, 6, 60, 8, 'Normal', '125/80', 75, 10000, 'None'),
(3, 'Male', 28, 'Doctor', 6.2, 6, 60, 8, 'Normal', '125/80', 75, 10000, 'None'),
(4, 'Male', 28, 'Sales Representative', 5.9, 4, 30, 8, 'Obese', '140/90', 85, 3000, 'Sleep Apnea'),
(5, 'Male', 28, 'Sales Representative', 5.9, 4, 30, 8, 'Obese', '140/90', 85, 3000, 'Sleep Apnea'),
(6, 'Male', 28, 'Software Engineer', 5.9, 4, 30, 8, 'Obese', '140/90', 85, 3000, 'Insomnia'),
(7, 'Male', 29, 'Teacher', 6.3, 6, 40, 7, 'Obese', '140/90', 82, 3500, 'Insomnia'),
(8, 'Male', 29, 'Doctor', 7.8, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(9, 'Male', 29, 'Doctor', 7.8, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(10, 'Male', 29, 'Doctor', 7.8, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(11, 'Male', 29, 'Doctor', 6.1, 6, 30, 8, 'Normal', '120/80', 70, 8000, 'None'),
(12, 'Male', 29, 'Doctor', 7.8, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(13, 'Male', 29, 'Doctor', 6.1, 6, 30, 8, 'Normal', '120/80', 70, 8000, 'None'),
(14, 'Male', 29, 'Doctor', 6, 6, 30, 8, 'Normal', '120/80', 70, 8000, 'None'),
(15, 'Male', 29, 'Doctor', 6, 6, 30, 8, 'Normal', '120/80', 70, 8000, 'None'),
(16, 'Male', 29, 'Doctor', 6, 6, 30, 8, 'Normal', '120/80', 70, 8000, 'None'),
(17, 'Female', 29, 'Nurse', 6.5, 5, 40, 7, 'Normal Weight', '132/87', 80, 4000, 'Sleep Apnea'),
(18, 'Male', 29, 'Doctor', 6, 6, 30, 8, 'Normal', '120/80', 70, 8000, 'Sleep Apnea'),
(19, 'Female', 29, 'Nurse', 6.5, 5, 40, 7, 'Normal Weight', '132/87', 80, 4000, 'Insomnia'),
(20, 'Male', 30, 'Doctor', 7.6, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(21, 'Male', 30, 'Doctor', 7.7, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(22, 'Male', 30, 'Doctor', 7.7, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(23, 'Male', 30, 'Doctor', 7.7, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(24, 'Male', 30, 'Doctor', 7.7, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(25, 'Male', 30, 'Doctor', 7.8, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(26, 'Male', 30, 'Doctor', 7.9, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(27, 'Male', 30, 'Doctor', 7.8, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(28, 'Male', 30, 'Doctor', 7.9, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(29, 'Male', 30, 'Doctor', 7.9, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(30, 'Male', 30, 'Doctor', 7.9, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(31, 'Female', 30, 'Nurse', 6.4, 5, 35, 7, 'Normal Weight', '130/86', 78, 4100, 'Sleep Apnea'),
(32, 'Female', 30, 'Nurse', 6.4, 5, 35, 7, 'Normal Weight', '130/86', 78, 4100, 'Insomnia'),
(33, 'Female', 31, 'Nurse', 7.9, 8, 75, 4, 'Normal Weight', '117/76', 69, 6800, 'None'),
(34, 'Male', 31, 'Doctor', 6.1, 6, 30, 8, 'Normal', '125/80', 72, 5000, 'None'),
(35, 'Male', 31, 'Doctor', 7.7, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(36, 'Male', 31, 'Doctor', 6.1, 6, 30, 8, 'Normal', '125/80', 72, 5000, 'None'),
(37, 'Male', 31, 'Doctor', 6.1, 6, 30, 8, 'Normal', '125/80', 72, 5000, 'None'),
(38, 'Male', 31, 'Doctor', 7.6, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(39, 'Male', 31, 'Doctor', 7.6, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(40, 'Male', 31, 'Doctor', 7.6, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(41, 'Male', 31, 'Doctor', 7.7, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(42, 'Male', 31, 'Doctor', 7.7, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(43, 'Male', 31, 'Doctor', 7.7, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(44, 'Male', 31, 'Doctor', 7.8, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(45, 'Male', 31, 'Doctor', 7.7, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(46, 'Male', 31, 'Doctor', 7.8, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(47, 'Male', 31, 'Doctor', 7.7, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(48, 'Male', 31, 'Doctor', 7.8, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(49, 'Male', 31, 'Doctor', 7.7, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(50, 'Male', 31, 'Doctor', 7.7, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'Sleep Apnea'),
(51, 'Male', 32, 'Engineer', 7.5, 8, 45, 3, 'Normal', '120/80', 70, 8000, 'None'),
(52, 'Male', 32, 'Engineer', 7.5, 8, 45, 3, 'Normal', '120/80', 70, 8000, 'None'),
(53, 'Male', 32, 'Doctor', 6, 6, 30, 8, 'Normal', '125/80', 72, 5000, 'None'),
(54, 'Male', 32, 'Doctor', 7.6, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(55, 'Male', 32, 'Doctor', 6, 6, 30, 8, 'Normal', '125/80', 72, 5000, 'None'),
(56, 'Male', 32, 'Doctor', 6, 6, 30, 8, 'Normal', '125/80', 72, 5000, 'None'),
(57, 'Male', 32, 'Doctor', 7.7, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(58, 'Male', 32, 'Doctor', 6, 6, 30, 8, 'Normal', '125/80', 72, 5000, 'None'),
(59, 'Male', 32, 'Doctor', 6, 6, 30, 8, 'Normal', '125/80', 72, 5000, 'None'),
(60, 'Male', 32, 'Doctor', 7.7, 7, 75, 6, 'Normal', '120/80', 70, 8000, 'None'),
(61, 'Male', 32, 'Doctor', 6, 6, 30, 8, 'Normal', '125/80', 72, 5000, 'None'),
(62, 'Male', 32, 'Doctor', 6, 6, 30, 8, 'Normal', '125/80', 72, 5000, 'None'),
(63, 'Male', 32, 'Doctor', 6.2, 6, 30, 8, 'Normal', '125/80', 72, 5000, 'None'),
(64, 'Male', 32, 'Doctor', 6.2, 6, 30, 8, 'Normal', '125/80', 72, 5000, 'None'),
(65, 'Male', 32, 'Doctor', 6.2, 6, 30, 8, 'Normal', '125/80', 72, 5000, 'None'),
(66, 'Male', 32, 'Doctor', 6.2, 6, 30, 8, 'Normal', '125/80', 72, 5000, 'None'),
(67, 'Male', 32, 'Accountant', 7.2, 8, 50, 6, 'Normal Weight', '118/76', 68, 7000, 'None'),
(68, 'Male', 33, 'Doctor', 6, 6, 30, 8, 'Normal', '125/80', 72, 5000, 'Insomnia'),
(69, 'Female', 33, 'Scientist', 6.2, 6, 50, 6, 'Overweight', '128/85', 76, 5500, 'None'),
(70, 'Female', 33, 'Scientist', 6.2, 6, 50, 6, 'Overweight', '128/85', 76, 5500, 'None'),
(71, 'Male', 33, 'Doctor', 6.1, 6, 30, 8, 'Normal', '125/80', 72, 5000, 'None'),
(72, 'Male', 33, 'Doctor', 6.1, 6, 30, 8, 'Normal', '125/80', 72, 5000, 'None'),
(73, 'Male', 33, 'Doctor', 6.1, 6, 30, 8, 'Normal', '125/80', 72, 5000, 'None'),
(74, 'Male', 33, 'Doctor', 6.1, 6, 30, 8, 'Normal', '125/80', 72, 5000, 'None'),
(75, 'Male', 33, 'Doctor', 6, 6, 30, 8, 'Normal', '125/80', 72, 5000, 'None'),
(76, 'Male', 33, 'Doctor', 6, 6, 30, 8, 'Normal', '125/80', 72, 5000, 'None'),
(77, 'Male', 33, 'Doctor', 6, 6, 30, 8, 'Normal', '125/80', 72, 5000, 'None'),
(78, 'Male', 33, 'Doctor', 6, 6, 30, 8, 'Normal', '125/80', 72, 5000, 'None'),
(79, 'Male', 33, 'Doctor', 6, 6, 30, 8, 'Normal', '125/80', 72, 5000, 'None'),
(80, 'Male', 33, 'Doctor', 6, 6, 30, 8, 'Normal', '125/80', 72, 5000, 'None'),
(81, 'Female', 34, 'Scientist', 5.8, 4, 32, 8, 'Overweight', '131/86', 81, 5200, 'Sleep Apnea'),
(82, 'Female', 34, 'Scientist', 5.8, 4, 32, 8, 'Overweight', '131/86', 81, 5200, 'Sleep Apnea'),
(83, 'Male', 35, 'Teacher', 6.7, 7, 40, 5, 'Overweight', '128/84', 70, 5600, 'None'),
(84, 'Male', 35, 'Teacher', 6.7, 7, 40, 5, 'Overweight', '128/84', 70, 5600, 'None'),
(85, 'Male', 35, 'Software Engineer', 7.5, 8, 60, 5, 'Normal Weight', '120/80', 70, 8000, 'None'),
(86, 'Female', 35, 'Accountant', 7.2, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'None'),
(87, 'Male', 35, 'Engineer', 7.2, 8, 60, 4, 'Normal', '125/80', 65, 5000, 'None'),
(88, 'Male', 35, 'Engineer', 7.2, 8, 60, 4, 'Normal', '125/80', 65, 5000, 'None'),
(89, 'Male', 35, 'Engineer', 7.3, 8, 60, 4, 'Normal', '125/80', 65, 5000, 'None'),
(90, 'Male', 35, 'Engineer', 7.3, 8, 60, 4, 'Normal', '125/80', 65, 5000, 'None'),
(91, 'Male', 35, 'Engineer', 7.3, 8, 60, 4, 'Normal', '125/80', 65, 5000, 'None'),
(92, 'Male', 35, 'Engineer', 7.3, 8, 60, 4, 'Normal', '125/80', 65, 5000, 'None'),
(93, 'Male', 35, 'Software Engineer', 7.5, 8, 60, 5, 'Normal Weight', '120/80', 70, 8000, 'None'),
(94, 'Male', 35, 'Lawyer', 7.4, 7, 60, 5, 'Obese', '135/88', 84, 3300, 'Sleep Apnea'),
(95, 'Female', 36, 'Accountant', 7.2, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'Insomnia'),
(96, 'Female', 36, 'Accountant', 7.1, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'None'),
(97, 'Female', 36, 'Accountant', 7.2, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'None'),
(98, 'Female', 36, 'Accountant', 7.1, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'None'),
(99, 'Female', 36, 'Teacher', 7.1, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'None'),
(100, 'Female', 36, 'Teacher', 7.1, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'None'),
(101, 'Female', 36, 'Teacher', 7.2, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'None'),
(102, 'Female', 36, 'Teacher', 7.2, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'None'),
(103, 'Female', 36, 'Teacher', 7.2, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'None'),
(104, 'Male', 36, 'Teacher', 6.6, 5, 35, 7, 'Overweight', '129/84', 74, 4800, 'Sleep Apnea'),
(105, 'Female', 36, 'Teacher', 7.2, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'Sleep Apnea'),
(106, 'Male', 36, 'Teacher', 6.6, 5, 35, 7, 'Overweight', '129/84', 74, 4800, 'Insomnia'),
(107, 'Female', 37, 'Nurse', 6.1, 6, 42, 6, 'Overweight', '126/83', 77, 4200, 'None'),
(108, 'Male', 37, 'Engineer', 7.8, 8, 70, 4, 'Normal Weight', '120/80', 68, 7000, 'None'),
(109, 'Male', 37, 'Engineer', 7.8, 8, 70, 4, 'Normal Weight', '120/80', 68, 7000, 'None'),
(110, 'Male', 37, 'Lawyer', 7.4, 8, 60, 5, 'Normal', '130/85', 68, 8000, 'None'),
(111, 'Female', 37, 'Accountant', 7.2, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'None'),
(112, 'Male', 37, 'Lawyer', 7.4, 8, 60, 5, 'Normal', '130/85', 68, 8000, 'None'),
(113, 'Female', 37, 'Accountant', 7.2, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'None'),
(114, 'Male', 37, 'Lawyer', 7.4, 8, 60, 5, 'Normal', '130/85', 68, 8000, 'None'),
(115, 'Female', 37, 'Accountant', 7.2, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'None'),
(116, 'Female', 37, 'Accountant', 7.2, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'None'),
(117, 'Female', 37, 'Accountant', 7.2, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'None'),
(118, 'Female', 37, 'Accountant', 7.2, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'None'),
(119, 'Female', 37, 'Accountant', 7.2, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'None'),
(120, 'Female', 37, 'Accountant', 7.2, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'None'),
(121, 'Female', 37, 'Accountant', 7.2, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'None'),
(122, 'Female', 37, 'Accountant', 7.2, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'None'),
(123, 'Female', 37, 'Accountant', 7.2, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'None'),
(124, 'Female', 37, 'Accountant', 7.2, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'None'),
(125, 'Female', 37, 'Accountant', 7.2, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'None'),
(126, 'Female', 37, 'Nurse', 7.5, 8, 60, 4, 'Normal Weight', '120/80', 70, 8000, 'None'),
(127, 'Male', 38, 'Lawyer', 7.3, 8, 60, 5, 'Normal', '130/85', 68, 8000, 'None'),
(128, 'Female', 38, 'Accountant', 7.1, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'None'),
(129, 'Male', 38, 'Lawyer', 7.3, 8, 60, 5, 'Normal', '130/85', 68, 8000, 'None'),
(130, 'Male', 38, 'Lawyer', 7.3, 8, 60, 5, 'Normal', '130/85', 68, 8000, 'None'),
(131, 'Female', 38, 'Accountant', 7.1, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'None'),
(132, 'Male', 38, 'Lawyer', 7.3, 8, 60, 5, 'Normal', '130/85', 68, 8000, 'None'),
(133, 'Male', 38, 'Lawyer', 7.3, 8, 60, 5, 'Normal', '130/85', 68, 8000, 'None'),
(134, 'Female', 38, 'Accountant', 7.1, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'None'),
(135, 'Male', 38, 'Lawyer', 7.3, 8, 60, 5, 'Normal', '130/85', 68, 8000, 'None'),
(136, 'Male', 38, 'Lawyer', 7.3, 8, 60, 5, 'Normal', '130/85', 68, 8000, 'None'),
(137, 'Female', 38, 'Accountant', 7.1, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'None'),
(138, 'Male', 38, 'Lawyer', 7.1, 8, 60, 5, 'Normal', '130/85', 68, 8000, 'None'),
(139, 'Female', 38, 'Accountant', 7.1, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'None'),
(140, 'Male', 38, 'Lawyer', 7.1, 8, 60, 5, 'Normal', '130/85', 68, 8000, 'None'),
(141, 'Female', 38, 'Accountant', 7.1, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'None'),
(142, 'Male', 38, 'Lawyer', 7.1, 8, 60, 5, 'Normal', '130/85', 68, 8000, 'None'),
(143, 'Female', 38, 'Accountant', 7.1, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'None'),
(144, 'Female', 38, 'Accountant', 7.1, 8, 60, 4, 'Normal', '115/75', 68, 7000, 'None'),
(145, 'Male', 38, 'Lawyer', 7.1, 8, 60, 5, 'Normal', '130/85', 68, 8000, 'Sleep Apnea'),
(146, 'Female', 38, 'Lawyer', 7.4, 7, 60, 5, 'Obese', '135/88', 84, 3300, 'Sleep Apnea'),
(147, 'Male', 39, 'Lawyer', 7.2, 8, 60, 5, 'Normal', '130/85', 68, 8000, 'Insomnia'),
(148, 'Male', 39, 'Engineer', 6.5, 5, 40, 7, 'Overweight', '132/87', 80, 4000, 'Insomnia'),
(149, 'Female', 39, 'Lawyer', 6.9, 7, 50, 6, 'Normal Weight', '128/85', 75, 5500, 'None'),
(150, 'Female', 39, 'Accountant', 8, 9, 80, 3, 'Normal Weight', '115/78', 67, 7500, 'None'),
(151, 'Female', 39, 'Accountant', 8, 9, 80, 3, 'Normal Weight', '115/78', 67, 7500, 'None'),
(152, 'Male', 39, 'Lawyer', 7.2, 8, 60, 5, 'Normal', '130/85', 68, 8000, 'None'),
(153, 'Male', 39, 'Lawyer', 7.2, 8, 60, 5, 'Normal', '130/85', 68, 8000, 'None'),
(154, 'Male', 39, 'Lawyer', 7.2, 8, 60, 5, 'Normal', '130/85', 68, 8000, 'None'),
(155, 'Male', 39, 'Lawyer', 7.2, 8, 60, 5, 'Normal', '130/85', 68, 8000, 'None'),
(156, 'Male', 39, 'Lawyer', 7.2, 8, 60, 5, 'Normal', '130/85', 68, 8000, 'None'),
(157, 'Male', 39, 'Lawyer', 7.2, 8, 60, 5, 'Normal', '130/85', 68, 8000, 'None'),
(158, 'Male', 39, 'Lawyer', 7.2, 8, 60, 5, 'Normal', '130/85', 68, 8000, 'None'),
(159, 'Male', 39, 'Lawyer', 7.2, 8, 60, 5, 'Normal', '130/85', 68, 8000, 'None'),
(160, 'Male', 39, 'Lawyer', 7.2, 8, 60, 5, 'Normal', '130/85', 68, 8000, 'None'),
(161, 'Male', 39, 'Lawyer', 7.2, 8, 60, 5, 'Normal', '130/85', 68, 8000, 'None'),
(162, 'Female', 40, 'Accountant', 7.2, 8, 55, 6, 'Normal Weight', '119/77', 73, 7300, 'None'),
(163, 'Female', 40, 'Accountant', 7.2, 8, 55, 6, 'Normal Weight', '119/77', 73, 7300, 'None'),
(164, 'Male', 40, 'Lawyer', 7.9, 8, 90, 5, 'Normal', '130/85', 68, 8000, 'None'),
(165, 'Male', 40, 'Lawyer', 7.9, 8, 90, 5, 'Normal', '130/85', 68, 8000, 'None'),
(166, 'Male', 41, 'Lawyer', 7.6, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'Insomnia'),
(167, 'Male', 41, 'Engineer', 7.3, 8, 70, 6, 'Normal Weight', '121/79', 72, 6200, 'None'),
(168, 'Male', 41, 'Lawyer', 7.1, 7, 55, 6, 'Overweight', '125/82', 72, 6000, 'None'),
(169, 'Male', 41, 'Lawyer', 7.1, 7, 55, 6, 'Overweight', '125/82', 72, 6000, 'None'),
(170, 'Male', 41, 'Lawyer', 7.7, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'None'),
(171, 'Male', 41, 'Lawyer', 7.7, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'None'),
(172, 'Male', 41, 'Lawyer', 7.7, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'None'),
(173, 'Male', 41, 'Lawyer', 7.7, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'None'),
(174, 'Male', 41, 'Lawyer', 7.7, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'None'),
(175, 'Male', 41, 'Lawyer', 7.6, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'None'),
(176, 'Male', 41, 'Lawyer', 7.6, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'None'),
(177, 'Male', 41, 'Lawyer', 7.6, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'None'),
(178, 'Male', 42, 'Salesperson', 6.5, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'Insomnia'),
(179, 'Male', 42, 'Lawyer', 7.8, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'None'),
(180, 'Male', 42, 'Lawyer', 7.8, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'None'),
(181, 'Male', 42, 'Lawyer', 7.8, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'None'),
(182, 'Male', 42, 'Lawyer', 7.8, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'None'),
(183, 'Male', 42, 'Lawyer', 7.8, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'None'),
(184, 'Male', 42, 'Lawyer', 7.8, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'None'),
(185, 'Female', 42, 'Teacher', 6.8, 6, 45, 7, 'Overweight', '130/85', 78, 5000, 'Sleep Apnea'),
(186, 'Female', 42, 'Teacher', 6.8, 6, 45, 7, 'Overweight', '130/85', 78, 5000, 'Sleep Apnea'),
(187, 'Female', 43, 'Teacher', 6.7, 7, 45, 4, 'Overweight', '135/90', 65, 6000, 'Insomnia'),
(188, 'Male', 43, 'Salesperson', 6.3, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'Insomnia'),
(189, 'Female', 43, 'Teacher', 6.7, 7, 45, 4, 'Overweight', '135/90', 65, 6000, 'Insomnia'),
(190, 'Male', 43, 'Salesperson', 6.5, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'Insomnia'),
(191, 'Female', 43, 'Teacher', 6.7, 7, 45, 4, 'Overweight', '135/90', 65, 6000, 'Insomnia'),
(192, 'Male', 43, 'Salesperson', 6.4, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'Insomnia'),
(193, 'Male', 43, 'Salesperson', 6.5, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'Insomnia'),
(194, 'Male', 43, 'Salesperson', 6.5, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'Insomnia'),
(195, 'Male', 43, 'Salesperson', 6.5, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'Insomnia'),
(196, 'Male', 43, 'Salesperson', 6.5, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'Insomnia'),
(197, 'Male', 43, 'Salesperson', 6.5, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'Insomnia'),
(198, 'Male', 43, 'Salesperson', 6.5, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'Insomnia'),
(199, 'Male', 43, 'Salesperson', 6.5, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'Insomnia'),
(200, 'Male', 43, 'Salesperson', 6.5, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'Insomnia'),
(201, 'Male', 43, 'Salesperson', 6.5, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'Insomnia'),
(202, 'Male', 43, 'Engineer', 7.8, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'Insomnia'),
(203, 'Male', 43, 'Engineer', 7.8, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'Insomnia'),
(204, 'Male', 43, 'Engineer', 6.9, 6, 47, 7, 'Normal Weight', '117/76', 69, 6800, 'None'),
(205, 'Male', 43, 'Engineer', 7.6, 8, 75, 4, 'Overweight', '122/80', 68, 6800, 'None'),
(206, 'Male', 43, 'Engineer', 7.7, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'None'),
(207, 'Male', 43, 'Engineer', 7.7, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'None'),
(208, 'Male', 43, 'Engineer', 7.7, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'None'),
(209, 'Male', 43, 'Engineer', 7.7, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'None'),
(210, 'Male', 43, 'Engineer', 7.8, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'None'),
(211, 'Male', 43, 'Engineer', 7.7, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'None'),
(212, 'Male', 43, 'Engineer', 7.8, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'None'),
(213, 'Male', 43, 'Engineer', 7.8, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'None'),
(214, 'Male', 43, 'Engineer', 7.8, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'None'),
(215, 'Male', 43, 'Engineer', 7.8, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'None'),
(216, 'Male', 43, 'Engineer', 7.8, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'None'),
(217, 'Male', 43, 'Engineer', 7.8, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'None'),
(218, 'Male', 43, 'Engineer', 7.8, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'None'),
(219, 'Male', 43, 'Engineer', 7.8, 8, 90, 5, 'Normal', '130/85', 70, 8000, 'Sleep Apnea'),
(220, 'Male', 43, 'Salesperson', 6.5, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'Sleep Apnea'),
(221, 'Female', 44, 'Teacher', 6.6, 7, 45, 4, 'Overweight', '135/90', 65, 6000, 'Insomnia'),
(222, 'Male', 44, 'Salesperson', 6.4, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'Insomnia'),
(223, 'Male', 44, 'Salesperson', 6.3, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'Insomnia'),
(224, 'Male', 44, 'Salesperson', 6.4, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'Insomnia'),
(225, 'Female', 44, 'Teacher', 6.6, 7, 45, 4, 'Overweight', '135/90', 65, 6000, 'Insomnia'),
(226, 'Male', 44, 'Salesperson', 6.3, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'Insomnia'),
(227, 'Female', 44, 'Teacher', 6.6, 7, 45, 4, 'Overweight', '135/90', 65, 6000, 'Insomnia'),
(228, 'Male', 44, 'Salesperson', 6.3, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'Insomnia'),
(229, 'Female', 44, 'Teacher', 6.6, 7, 45, 4, 'Overweight', '135/90', 65, 6000, 'Insomnia'),
(230, 'Male', 44, 'Salesperson', 6.3, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'Insomnia'),
(231, 'Female', 44, 'Teacher', 6.6, 7, 45, 4, 'Overweight', '135/90', 65, 6000, 'Insomnia'),
(232, 'Male', 44, 'Salesperson', 6.3, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'Insomnia'),
(233, 'Female', 44, 'Teacher', 6.6, 7, 45, 4, 'Overweight', '135/90', 65, 6000, 'Insomnia'),
(234, 'Male', 44, 'Salesperson', 6.3, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'Insomnia'),
(235, 'Female', 44, 'Teacher', 6.6, 7, 45, 4, 'Overweight', '135/90', 65, 6000, 'Insomnia'),
(236, 'Male', 44, 'Salesperson', 6.3, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'Insomnia'),
(237, 'Male', 44, 'Salesperson', 6.4, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'Insomnia'),
(238, 'Female', 44, 'Teacher', 6.5, 7, 45, 4, 'Overweight', '135/90', 65, 6000, 'Insomnia'),
(239, 'Male', 44, 'Salesperson', 6.3, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'Insomnia'),
(240, 'Male', 44, 'Salesperson', 6.4, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'Insomnia'),
(241, 'Female', 44, 'Teacher', 6.5, 7, 45, 4, 'Overweight', '135/90', 65, 6000, 'Insomnia'),
(242, 'Male', 44, 'Salesperson', 6.3, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'Insomnia'),
(243, 'Male', 44, 'Salesperson', 6.4, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'Insomnia'),
(244, 'Female', 44, 'Teacher', 6.5, 7, 45, 4, 'Overweight', '135/90', 65, 6000, 'Insomnia'),
(245, 'Male', 44, 'Salesperson', 6.3, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'Insomnia'),
(246, 'Female', 44, 'Teacher', 6.5, 7, 45, 4, 'Overweight', '135/90', 65, 6000, 'Insomnia'),
(247, 'Male', 44, 'Salesperson', 6.3, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'Insomnia'),
(248, 'Male', 44, 'Engineer', 6.8, 7, 45, 7, 'Overweight', '130/85', 78, 5000, 'Insomnia'),
(249, 'Male', 44, 'Salesperson', 6.4, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'None'),
(250, 'Male', 44, 'Salesperson', 6.5, 6, 45, 7, 'Overweight', '130/85', 72, 6000, 'None'),
(251, 'Female', 45, 'Teacher', 6.8, 7, 30, 6, 'Overweight', '135/90', 65, 6000, 'Insomnia'),
(252, 'Female', 45, 'Teacher', 6.8, 7, 30, 6, 'Overweight', '135/90', 65, 6000, 'Insomnia'),
(253, 'Female', 45, 'Teacher', 6.5, 7, 45, 4, 'Overweight', '135/90', 65, 6000, 'Insomnia'),
(254, 'Female', 45, 'Teacher', 6.5, 7, 45, 4, 'Overweight', '135/90', 65, 6000, 'Insomnia'),
(255, 'Female', 45, 'Teacher', 6.5, 7, 45, 4, 'Overweight', '135/90', 65, 6000, 'Insomnia'),
(256, 'Female', 45, 'Teacher', 6.5, 7, 45, 4, 'Overweight', '135/90', 65, 6000, 'Insomnia'),
(257, 'Female', 45, 'Teacher', 6.6, 7, 45, 4, 'Overweight', '135/90', 65, 6000, 'Insomnia'),
(258, 'Female', 45, 'Teacher', 6.6, 7, 45, 4, 'Overweight', '135/90', 65, 6000, 'Insomnia'),
(259, 'Female', 45, 'Teacher', 6.6, 7, 45, 4, 'Overweight', '135/90', 65, 6000, 'Insomnia'),
(260, 'Female', 45, 'Teacher', 6.6, 7, 45, 4, 'Overweight', '135/90', 65, 6000, 'Insomnia'),
(261, 'Female', 45, 'Teacher', 6.6, 7, 45, 4, 'Overweight', '135/90', 65, 6000, 'Insomnia'),
(262, 'Female', 45, 'Teacher', 6.6, 7, 45, 4, 'Overweight', '135/90', 65, 6000, 'None'),
(263, 'Female', 45, 'Teacher', 6.6, 7, 45, 4, 'Overweight', '135/90', 65, 6000, 'None'),
(264, 'Female', 45, 'Manager', 6.9, 7, 55, 5, 'Overweight', '125/82', 75, 5500, 'None'),
(265, 'Male', 48, 'Doctor', 7.3, 7, 65, 5, 'Obese', '142/92', 83, 3500, 'Insomnia'),
(266, 'Female', 48, 'Nurse', 5.9, 6, 90, 8, 'Overweight', '140/95', 75, 10000, 'Sleep Apnea'),
(267, 'Male', 48, 'Doctor', 7.3, 7, 65, 5, 'Obese', '142/92', 83, 3500, 'Insomnia'),
(268, 'Female', 49, 'Nurse', 6.2, 6, 90, 8, 'Overweight', '140/95', 75, 10000, 'None'),
(269, 'Female', 49, 'Nurse', 6, 6, 90, 8, 'Overweight', '140/95', 75, 10000, 'Sleep Apnea'),
(270, 'Female', 49, 'Nurse', 6.1, 6, 90, 8, 'Overweight', '140/95', 75, 10000, 'Sleep Apnea'),
(271, 'Female', 49, 'Nurse', 6.1, 6, 90, 8, 'Overweight', '140/95', 75, 10000, 'Sleep Apnea'),
(272, 'Female', 49, 'Nurse', 6.1, 6, 90, 8, 'Overweight', '140/95', 75, 10000, 'Sleep Apnea'),
(273, 'Female', 49, 'Nurse', 6.1, 6, 90, 8, 'Overweight', '140/95', 75, 10000, 'Sleep Apnea'),
(274, 'Female', 49, 'Nurse', 6.2, 6, 90, 8, 'Overweight', '140/95', 75, 10000, 'Sleep Apnea'),
(275, 'Female', 49, 'Nurse', 6.2, 6, 90, 8, 'Overweight', '140/95', 75, 10000, 'Sleep Apnea'),
(276, 'Female', 49, 'Nurse', 6.2, 6, 90, 8, 'Overweight', '140/95', 75, 10000, 'Sleep Apnea'),
(277, 'Male', 49, 'Doctor', 8.1, 9, 85, 3, 'Obese', '139/91', 86, 3700, 'Sleep Apnea'),
(278, 'Male', 49, 'Doctor', 8.1, 9, 85, 3, 'Obese', '139/91', 86, 3700, 'Sleep Apnea'),
(279, 'Female', 50, 'Nurse', 6.1, 6, 90, 8, 'Overweight', '140/95', 75, 10000, 'Insomnia'),
(280, 'Female', 50, 'Engineer', 8.3, 9, 30, 3, 'Normal', '125/80', 65, 5000, 'None'),
(281, 'Female', 50, 'Nurse', 6, 6, 90, 8, 'Overweight', '140/95', 75, 10000, 'None'),
(282, 'Female', 50, 'Nurse', 6.1, 6, 90, 8, 'Overweight', '140/95', 75, 10000, 'Sleep Apnea'),
(283, 'Female', 50, 'Nurse', 6, 6, 90, 8, 'Overweight', '140/95', 75, 10000, 'Sleep Apnea'),
(284, 'Female', 50, 'Nurse', 6, 6, 90, 8, 'Overweight', '140/95', 75, 10000, 'Sleep Apnea'),
(285, 'Female', 50, 'Nurse', 6, 6, 90, 8, 'Overweight', '140/95', 75, 10000, 'Sleep Apnea'),
(286, 'Female', 50, 'Nurse', 6, 6, 90, 8, 'Overweight', '140/95', 75, 10000, 'Sleep Apnea'),
(287, 'Female', 50, 'Nurse', 6, 6, 90, 8, 'Overweight', '140/95', 75, 10000, 'Sleep Apnea'),
(288, 'Female', 50, 'Nurse', 6, 6, 90, 8, 'Overweight', '140/95', 75, 10000, 'Sleep Apnea'),
(289, 'Female', 50, 'Nurse', 6, 6, 90, 8, 'Overweight', '140/95', 75, 10000, 'Sleep Apnea'),
(290, 'Female', 50, 'Nurse', 6.1, 6, 90, 8, 'Overweight', '140/95', 75, 10000, 'Sleep Apnea'),
(291, 'Female', 50, 'Nurse', 6, 6, 90, 8, 'Overweight', '140/95', 75, 10000, 'Sleep Apnea'),
(292, 'Female', 50, 'Nurse', 6.1, 6, 90, 8, 'Overweight', '140/95', 75, 10000, 'Sleep Apnea'),
(293, 'Female', 50, 'Nurse', 6.1, 6, 90, 8, 'Overweight', '140/95', 75, 10000, 'Sleep Apnea'),
(294, 'Female', 50, 'Nurse', 6, 6, 90, 8, 'Overweight', '140/95', 75, 10000, 'Sleep Apnea');




-- Populate(s) lookup tables from the temp_import (at least ideally, although not working at the moment) ...
INSERT INTO BMI (category) 
SELECT DISTINCT bmi_category FROM temp_import WHERE bmi_category IS NOT NULL;

INSERT INTO Sleep_Disorder (disorder) 
SELECT DISTINCT sleep_disorder FROM temp_import WHERE sleep_disorder IS NOT NULL;

-- Person table
INSERT INTO Person (person_id, gender, age, occupation, bmi_category_id, sleep_disorder_id)
SELECT 
    ti.person_id,
    ti.gender,
    ti.age,
    ti.occupation,
    b.id,
    sd.id
FROM temp_import ti
LEFT JOIN BMI b ON ti.bmi_category = b.category
LEFT JOIN Sleep_Disorder sd ON ti.sleep_disorder = sd.disorder;

-- Populate HealthMetrics table (using current date as recorded date)
INSERT INTO HealthMetrics (person_id, date_recorded, sleep_duration, sleep_quality, activity_minutes, stress_level, blood_pressure_sys, blood_pressure_dia, heart_rate, daily_steps)
SELECT 
    ti.person_id,
    CURDATE() as date_recorded,
    ti.sleep_duration,
    ti.sleep_quality,
    ti.activity_minutes,
    ti.stress_level,
    CAST(SUBSTRING_INDEX(ti.blood_pressure, '/', 1) AS UNSIGNED) as blood_pressure_sys,
    CAST(SUBSTRING_INDEX(ti.blood_pressure, '/', -1) AS UNSIGNED) as blood_pressure_dia,
    ti.heart_rate,
    ti.daily_steps
FROM temp_import ti;

-- Clean up the temporary table
DROP TABLE temp_import;



#### Data Inspection Requests, Statements, and Queries to validate the dataset ####

-- Verification of all of the data insertion(s)

-- TEST(s)
-- Expected: 294 Records... More if Records are updated.
-- BMI Count is expected to be 4.
-- Sleep Disorder Count is expected to be 3
-- Health Metrics should be in-line with the total records


SELECT COUNT(*) as person_count FROM Person;
SELECT COUNT(*) as bmi_count FROM BMI;
SELECT COUNT(*) as sleep_disorder_count FROM Sleep_Disorder;
SELECT COUNT(*) as health_metrics_count FROM HealthMetrics;

-- Showcases 20 rows as a header for the sample data. --
SELECT 'Sample Person Data:' as info;
SELECT p.person_id, p.gender, p.age, p.occupation, b.category as bmi_category, sd.disorder as sleep_disorder
FROM Person p
LEFT JOIN BMI b ON p.bmi_category_id = b.id
LEFT JOIN Sleep_Disorder sd ON p.sleep_disorder_id = sd.id
LIMIT 20;



SELECT 'Sample Health Metrics Data:' as info;
SELECT hm.metric_id, hm.person_id, hm.date_recorded, hm.sleep_duration, hm.sleep_quality, 
       CONCAT(hm.blood_pressure_sys, '/', hm.blood_pressure_dia) as blood_pressure,
       hm.heart_rate, hm.daily_steps
FROM HealthMetrics hm
LIMIT 20;

-- Check(s) for logical inconsistencies in terms of BP (systolic < diastolic)
SELECT COUNT(*) as invalid_bp_readings
FROM HealthMetrics
WHERE blood_pressure_sys <= blood_pressure_dia;


-- Age(s) are grouped, reclassified, and measured against 6 different 'age groups'
-- Case Statement made to categorize 6 different age groups with a count(), round(2) method(s) encased for aggregating this query statement.
SELECT 
    CASE 
        WHEN age < 25 THEN '18-24'
        WHEN age < 35 THEN '25-34'
        WHEN age < 45 THEN '35-44'
        WHEN age < 55 THEN '45-54'
        WHEN age < 65 THEN '55-64'
        ELSE '65+'
    END as age_group,
    
    COUNT(*) as count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Person), 2) as percentage
    
FROM Person
GROUP BY age_group
ORDER BY age_group;

-- Risk Assessment by Gender --
SELECT 
    gender,
    COUNT(*) as count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Person), 2) as percentage
    
FROM Person
GROUP BY gender;


-- BMI Assessment of the Observed Population --
SELECT 
    b.category,
    COUNT(*) as count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Person), 2) as percentage
    
FROM Person p
JOIN BMI b ON p.bmi_category_id = b.id
GROUP BY b.category
ORDER BY count DESC;

-- General Sleep Disorder Distribution -- 
SELECT 
    sd.disorder,
    COUNT(*) as count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Person), 2) as percentage
    
FROM Person p
JOIN Sleep_Disorder sd ON p.sleep_disorder_id = sd.id
GROUP BY sd.disorder
ORDER BY count DESC;


-- HEALTH METRICS ANALYSIS
-- ========================================

-- Overall health metrics summary
SELECT 
    COUNT(*) as total_records,
    ROUND(AVG(sleep_duration), 2) as avg_sleep_duration,
    ROUND(AVG(sleep_quality), 2) as avg_sleep_quality,
    ROUND(AVG(activity_minutes), 2) as avg_activity_minutes,
    ROUND(AVG(stress_level), 2) as avg_stress_level,
    ROUND(AVG(heart_rate), 2) as avg_heart_rate,
    ROUND(AVG(daily_steps), 2) as avg_daily_steps,
    ROUND(AVG(blood_pressure_sys), 2) as avg_systolic_bp,
    ROUND(AVG(blood_pressure_dia), 2) as avg_diastolic_bp
    
FROM HealthMetrics;


-- Sleep metrics by gender
-- Not enough records to make a viable statement, as the distribution of the record counts is slightly off and restricts this from happening.
SELECT 
    p.gender,
    COUNT(*) as count,
    ROUND(AVG(hm.sleep_duration), 2) as avg_sleep_duration,
    ROUND(AVG(hm.sleep_quality), 2) as avg_sleep_quality,
    ROUND(MIN(hm.sleep_duration), 2) as min_sleep_duration,
    ROUND(MAX(hm.sleep_duration), 2) as max_sleep_duration
    
FROM Person p
JOIN HealthMetrics hm ON p.person_id = hm.person_id
GROUP BY p.gender;


-- Health metrics by sleep disorder
-- The question that I've wanted to explore is what sleep disorder is most prevalent and are there other risk factors associated with a specific sleep disorder (ie, health metric wise)?
-- STILL an in progress assessment...
SELECT 
    sd.disorder,
    COUNT(*) as count,
    ROUND(AVG(hm.sleep_duration), 2) as avg_sleep_duration,
    ROUND(AVG(hm.sleep_quality), 2) as avg_sleep_quality,
    ROUND(AVG(hm.stress_level), 2) as avg_stress_level,
    ROUND(AVG(hm.heart_rate), 2) as avg_heart_rate
FROM Person p
JOIN Sleep_Disorder sd ON p.sleep_disorder_id = sd.id
JOIN HealthMetrics hm ON p.person_id = hm.person_id
GROUP BY sd.disorder
ORDER BY avg_sleep_quality DESC;


-- Activity level vs health metrics
-- Edit Note: created a case statement to categorize activity in moderations, as well as, inclusive with several other heart, sleep, and stress levels.

SELECT 
    CASE 
        WHEN activity_minutes < 30 THEN 'Low (<30min)'
        WHEN activity_minutes < 60 THEN 'Moderate (30-60min)'
        ELSE 'High (>60min)'
    END as activity_level,
    COUNT(*) as count,
    ROUND(AVG(sleep_quality), 2) as avg_sleep_quality,
    ROUND(AVG(stress_level), 2) as avg_stress_level,
    ROUND(AVG(heart_rate), 2) as avg_heart_rate
FROM HealthMetrics
GROUP BY activity_level
ORDER BY avg_sleep_quality DESC;


-- Poor Sleep Quality Analysis
-- Edit Note: eval on all health metrics to assess a general summary of what is required or what has contributed to sleep quality statements.
SELECT 
    p.person_id,
    p.age,
    p.gender,
    p.occupation,
    b.category as bmi_category,
    sd.disorder as sleep_disorder,
    hm.sleep_duration,
    hm.sleep_quality,
    hm.stress_level
FROM Person p
JOIN BMI b ON p.bmi_category_id = b.id
JOIN Sleep_Disorder sd ON p.sleep_disorder_id = sd.id
JOIN HealthMetrics hm ON p.person_id = hm.person_id
WHERE hm.sleep_quality <= 4 OR hm.sleep_duration < 6
ORDER BY hm.sleep_quality ASC, hm.sleep_duration ASC;

-- Health metrics by occupation
-- Edit Note: Answers all of my questions in relation to the occupation of participants from this dataset.
-- While Nurses may have the most steps per day, they also have the most stress in terms of levels at 7.56 out of 10, some of the worst avg sleep duration too at 6.22
-- Sleep duration/quality is amongst the best among accountants, engineers, lawyers, and teachers... Wonder what effect this has amongst sleep hygiene? 
SELECT 
    p.occupation,
    COUNT(*) AS count,
    ROUND(AVG(hm.sleep_duration), 2) AS avg_sleep_duration,
    ROUND(AVG(hm.sleep_quality), 2) AS avg_sleep_quality,
    ROUND(AVG(hm.stress_level), 2) AS avg_stress_level,
    ROUND(AVG(hm.activity_minutes), 2) AS avg_activity_minutes,
    ROUND(AVG(hm.daily_steps), 2) AS avg_daily_steps
FROM
    Person p
        JOIN
    HealthMetrics hm ON p.person_id = hm.person_id
GROUP BY p.occupation
ORDER BY avg_stress_level DESC;


-- Questions for the Dataset & Database Management:
-- 1) What are general health metrics that influence or that could contribute to sleep altercations?

-- This query is stil up for grabs, as there isn't enough data-points to systematically make assessments over correlation, however, generally speaking there are 'key indicators' of BMI, activity levels, and overall stress being somewhat impactful on sleep quality.
-- Meaning that if you are participating in taking care of yourself, there is a strong indication that you are going to be more likely to be able to avoid or potentially overcome sleep disorder factors as they may arise in life.alter

SELECT
  p.person_id,
  sd.disorder,
  h.sleep_duration,
  h.sleep_quality,
  h.stress_level,
  h.activity_minutes,
  h.blood_pressure_sys,
  h.blood_pressure_dia,
  h.heart_rate,
  h.daily_steps
FROM person p
JOIN sleep_disorder sd ON p.sleep_disorder_id = sd.id
JOIN healthmetrics h ON p.person_id = h.person_id
WHERE sd.disorder IS NOT NULL;





-- 2) Are there sleep hygiene practices that if recorded and measured that might influence the database dataset? Night Routines?

-- There isn't a conclusive statement expressed here, however, higher activity levels amongst participants were more likely to not have a sleep disorder, which though isn't a direct correlation could indicate that again its not a bad idea to take care of yourself now!
SELECT
  h.sleep_quality,
  h.activity_minutes,
  h.sleep_duration,
  sd.disorder
FROM person p
JOIN sleep_disorder sd ON p.sleep_disorder_id = sd.id
JOIN healthmetrics h ON p.person_id = h.person_id
WHERE sd.disorder IS NOT NULL;


-- 3) What occupation as recorded contributes to the most sleep disorders by count? Is there an occupation that represents diversity in reported sleep disorders, or are they uniformly spread without any linear relationships?

SELECT
  p.occupation,
  COUNT(*) AS disorder_count
FROM person p
JOIN sleep_disorder sd ON p.sleep_disorder_id = sd.id
WHERE sd.disorder IS NOT NULL
GROUP BY p.occupation
ORDER BY disorder_count DESC
LIMIT 1;



-- 4) What occupation as recorded contributes to the worst sleep quality and are there any correlated metrics like step count, exercise, or other BMI that could contribute to this? Is there an occupation that represents diversity in reported sleep disorders, or are they uniformly represented without any linear relationships?

-- While Nurses may have the most steps per day, they also have the most stress in terms of levels at 7.56 out of 10, some of the worst avg sleep duration too at 6.22
-- Sleep duration/quality is amongst the best among accountants, engineers, lawyers, and teachers... Wonder what effect this has amongst sleep hygiene? 

SELECT 
    p.occupation,
    COUNT(*) AS count,
    ROUND(AVG(hm.sleep_duration), 2) AS avg_sleep_duration,
    ROUND(AVG(hm.sleep_quality), 2) AS avg_sleep_quality,
    ROUND(AVG(hm.stress_level), 2) AS avg_stress_level,
    ROUND(AVG(hm.activity_minutes), 2) AS avg_activity_minutes,
    ROUND(AVG(hm.daily_steps), 2) AS avg_daily_steps
FROM
    Person p
        JOIN
    HealthMetrics hm ON p.person_id = hm.person_id
GROUP BY p.occupation
ORDER BY avg_stress_level DESC;

-- 6) What is the average sleep duration for users in the dataset, and how does it vary by age group?

-- Missing demographic information for ages 55+ which is disconcerting as this would also be a target demographic, and while not included here, it would also be pertinent to research how this affect adolescents, which is also not present within this study for this dataset.alter

SELECT 
    CASE 
        WHEN age < 25 THEN '18-24'
        WHEN age < 35 THEN '25-34'
        WHEN age < 45 THEN '35-44'
        WHEN age < 55 THEN '45-54'
        ELSE '55+'
    END as age_group,
    
    COUNT(*) as count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Person), 2) as percentage
    
FROM Person
GROUP BY age_group
ORDER BY age_group;



-- 7) What is the relationship between sleep duration and health metrics such as BMI, exercise frequency, and sleep disorders?
 
-- Relationships in this respect are still ambigious, as there isn't enough entries within the dataset to make a conclusive statement.
 
 SELECT
  h.sleep_duration,
  b.category AS bmi_category,
  h.activity_minutes,
  sd.disorder
  
FROM person p
JOIN healthmetrics h ON p.person_id = h.person_id
JOIN bmi b ON p.bmi_category_id = b.id
LEFT JOIN sleep_disorder sd ON p.sleep_disorder_id = sd.id;
