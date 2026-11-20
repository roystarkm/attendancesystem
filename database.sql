-- ============================================================================
-- Ndejje University Attendance Management System - Database Schema & Seed Data
-- Compatible with MySQL 5.7+ / MySQL 8.0+ / MariaDB 10.3+
-- Default Password for all seeded accounts: password
-- ============================================================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

CREATE DATABASE IF NOT EXISTS `attendance`
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE `attendance`;

-- ----------------------------------------------------------------------------
-- Drop existing tables (in reverse dependency order)
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS `system_logs`;
DROP TABLE IF EXISTS `attendance`;
DROP TABLE IF EXISTS `classes`;
DROP TABLE IF EXISTS `courses`;
DROP TABLE IF EXISTS `students`;
DROP TABLE IF EXISTS `users`;

-- ----------------------------------------------------------------------------
-- Table: users (System Administrators & Lecturers)
-- ----------------------------------------------------------------------------
CREATE TABLE `users` (
  `user_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `full_name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `role` ENUM('admin', 'lecturer') NOT NULL DEFAULT 'lecturer',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uk_users_username` (`username`),
  UNIQUE KEY `uk_users_email` (`email`),
  KEY `idx_users_role` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------------------------
-- Table: students
-- ----------------------------------------------------------------------------
CREATE TABLE `students` (
  `student_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `registration_number` VARCHAR(50) NOT NULL,
  `full_name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `program` VARCHAR(100) NOT NULL,
  `year_of_study` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`student_id`),
  UNIQUE KEY `uk_students_reg_no` (`registration_number`),
  UNIQUE KEY `uk_students_email` (`email`),
  KEY `idx_students_program` (`program`),
  KEY `idx_students_year` (`year_of_study`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------------------------
-- Table: courses
-- ----------------------------------------------------------------------------
CREATE TABLE `courses` (
  `course_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `course_code` VARCHAR(20) NOT NULL,
  `course_name` VARCHAR(150) NOT NULL,
  `credit_hours` TINYINT UNSIGNED NOT NULL DEFAULT 3,
  `program` VARCHAR(100) NOT NULL,
  `lecturer_id` INT UNSIGNED NULL DEFAULT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`course_id`),
  UNIQUE KEY `uk_courses_code` (`course_code`),
  KEY `idx_courses_lecturer` (`lecturer_id`),
  KEY `idx_courses_program` (`program`),
  CONSTRAINT `fk_courses_lecturer`
    FOREIGN KEY (`lecturer_id`) REFERENCES `users` (`user_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------------------------
-- Table: classes (Scheduled / Held Lecture Sessions)
-- ----------------------------------------------------------------------------
CREATE TABLE `classes` (
  `class_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `course_id` INT UNSIGNED NOT NULL,
  `lecturer_id` INT UNSIGNED NOT NULL,
  `class_date` DATE NOT NULL,
  `start_time` TIME NOT NULL,
  `end_time` TIME NOT NULL,
  `venue` VARCHAR(100) NOT NULL,
  `topic` VARCHAR(200) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`class_id`),
  KEY `idx_classes_course` (`course_id`),
  KEY `idx_classes_lecturer` (`lecturer_id`),
  KEY `idx_classes_date` (`class_date`),
  CONSTRAINT `fk_classes_course`
    FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_classes_lecturer`
    FOREIGN KEY (`lecturer_id`) REFERENCES `users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------------------------
-- Table: attendance
-- ----------------------------------------------------------------------------
CREATE TABLE `attendance` (
  `attendance_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `class_id` INT UNSIGNED NOT NULL,
  `student_id` INT UNSIGNED NOT NULL,
  `status` ENUM('present', 'absent', 'late') NOT NULL DEFAULT 'absent',
  `recorded_by` INT UNSIGNED NULL DEFAULT NULL,
  `recorded_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`attendance_id`),
  UNIQUE KEY `uk_attendance_class_student` (`class_id`, `student_id`),
  KEY `idx_attendance_student` (`student_id`),
  KEY `idx_attendance_status` (`status`),
  CONSTRAINT `fk_attendance_class`
    FOREIGN KEY (`class_id`) REFERENCES `classes` (`class_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_attendance_student`
    FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_attendance_recorder`
    FOREIGN KEY (`recorded_by`) REFERENCES `users` (`user_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------------------------
-- Table: system_logs (Audit Trail)
-- ----------------------------------------------------------------------------
CREATE TABLE `system_logs` (
  `log_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT UNSIGNED NULL DEFAULT NULL,
  `action` VARCHAR(255) NOT NULL,
  `ip_address` VARCHAR(45) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`log_id`),
  KEY `idx_logs_user` (`user_id`),
  KEY `idx_logs_created_at` (`created_at`),
  CONSTRAINT `fk_logs_user`
    FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- Seed Data (Password for all default users is: password)
-- ============================================================================

INSERT INTO `users` (`user_id`, `username`, `password`, `full_name`, `email`, `role`) VALUES
(1, 'admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'System Administrator', 'admin@ndejjeuniversity.ac.ug', 'admin'),
(2, 'hnantegge', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Hellen Nantegge', 'hnantegge@ndejjeuniversity.ac.ug', 'lecturer'),
(3, 'rmatsiko', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Roy Matsiko', 'rmatsiko@ndejjeuniversity.ac.ug', 'lecturer');

INSERT INTO `students` (`student_id`, `registration_number`, `full_name`, `email`, `program`, `year_of_study`) VALUES
(1, '25/2/314/WJ/065', 'Matsiko Roy', 'rmatsiko@students.ndejjeuniversity.ac.ug', 'Bachelor of Information Technology', 2),
(2, '25/2/314/W/002', 'Jjuuko Osward', 'josward@students.ndejjeuniversity.ac.ug', 'Bachelor of Information Technology', 2),
(3, '25/2/314/D/003', 'Alex Ssekabira', 'salex@students.ndejjeuniversity.ac.ug', 'Bachelor of Information Technology', 2),
(4, '25/2/314/W/004', 'Ogwang Moses', 'omoses@students.ndejjeuniversity.ac.ug', 'Bachelor of Information Technology', 2),
(5, '25/2/306/WJ/010', 'Ampaire Lamar', 'alamar@students.ndejjeuniversity.ac.ug', 'Bachelor of Computer Science', 2),
(6, '25/2/306/D/011', 'Kakuru Andrew', 'kandrew@students.ndejjeuniversity.ac.ug', 'Bachelor of Computer Science', 2),
(7, '25/2/201/D/015', 'Talemwa Johnson', 'tjohnson@students.ndejjeuniversity.ac.ug', 'Bachelor of Business Administration', 1),
(8, '25/2/201/D/016', 'Nakiyinji Ruth', 'nruth@students.ndejjeuniversity.ac.ug', 'Bachelor of Business Administration', 1);

INSERT INTO `courses` (`course_id`, `course_code`, `course_name`, `credit_hours`, `program`, `lecturer_id`) VALUES
(1, 'BIT2101', 'Web Application Development', 4, 'Bachelor of Information Technology', 2),
(2, 'BIT2103', 'Database Management Systems', 3, 'Bachelor of Information Technology', 3),
(3, 'BCS2102', 'Object Oriented Programming', 4, 'Bachelor of Computer Science', 2),
(4, 'BBA1101', 'Principles of Management', 3, 'Bachelor of Business Administration', 3);

INSERT INTO `classes` (`class_id`, `course_id`, `lecturer_id`, `class_date`, `start_time`, `end_time`, `venue`, `topic`) VALUES
(1, 1, 2, DATE_SUB(CURDATE(), INTERVAL 14 DAY), '08:00:00', '10:00:00', 'Lab 2 - Main Block', 'PHP & MySQL Architecture'),
(2, 1, 2, DATE_SUB(CURDATE(), INTERVAL 7 DAY), '08:00:00', '10:00:00', 'Lab 2 - Main Block', 'Session Security & PDO'),
(3, 1, 2, DATE_SUB(CURDATE(), INTERVAL 2 DAY), '08:00:00', '10:00:00', 'Lab 2 - Main Block', 'REST APIs & Reporting'),
(4, 2, 3, DATE_SUB(CURDATE(), INTERVAL 5 DAY), '11:00:00', '13:00:00', 'Room B14', 'Normalization & Indexing'),
(5, 3, 2, DATE_SUB(CURDATE(), INTERVAL 4 DAY), '14:00:00', '16:00:00', 'Lab 1 - ICT Wing', 'Inheritance & Polymorphism');

INSERT INTO `attendance` (`class_id`, `student_id`, `status`, `recorded_by`) VALUES
-- Class 1 (BIT2101)
(1, 1, 'present', 2),
(1, 2, 'present', 2),
(1, 3, 'absent', 2),
(1, 4, 'late', 2),
-- Class 2 (BIT2101)
(2, 1, 'present', 2),
(2, 2, 'present', 2),
(2, 3, 'present', 2),
(2, 4, 'absent', 2),
-- Class 3 (BIT2101)
(3, 1, 'present', 2),
(3, 2, 'late', 2),
(3, 3, 'absent', 2),
(3, 4, 'present', 2),
-- Class 4 (BIT2103)
(4, 1, 'present', 3),
(4, 2, 'present', 3),
(4, 3, 'present', 3),
(4, 4, 'present', 3),
-- Class 5 (BCS2102)
(5, 5, 'present', 2),
(5, 6, 'present', 2);

INSERT INTO `system_logs` (`user_id`, `action`, `ip_address`) VALUES
(1, 'Initial database schema and seed data initialized', '127.0.0.1'),
(2, 'Recorded attendance for class ID: 3', '127.0.0.1');

SET FOREIGN_KEY_CHECKS = 1;
