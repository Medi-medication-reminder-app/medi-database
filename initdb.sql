-- Adminer 4.8.0 MySQL 8.0.23 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP DATABASE IF EXISTS `mediusers`;
CREATE DATABASE `mediusers` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mediusers`;

DROP TABLE IF EXISTS `caretakers`;
CREATE TABLE `caretakers` (
  `caretaker_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `phone_number` int NOT NULL,
  PRIMARY KEY (`caretaker_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

TRUNCATE `caretakers`;

DROP TABLE IF EXISTS `concentrations`;
CREATE TABLE `concentrations` (
  `concentration_id` tinyint NOT NULL AUTO_INCREMENT,
  `concentration_amount` varchar(255) NOT NULL,
  PRIMARY KEY (`concentration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

TRUNCATE `concentrations`;

DROP TABLE IF EXISTS `conditions`;
CREATE TABLE `conditions` (
  `condition_id` int NOT NULL AUTO_INCREMENT,
  `condition_name` varchar(255) NOT NULL,
  `condition_details` varchar(255) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`condition_id`),
  KEY `user_info_id` (`user_id`),
  CONSTRAINT `conditions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

TRUNCATE `conditions`;

DROP TABLE IF EXISTS `dosages`;
CREATE TABLE `dosages` (
  `dosage_id` int NOT NULL AUTO_INCREMENT,
  `dosage_type` varchar(255) NOT NULL,
  PRIMARY KEY (`dosage_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

TRUNCATE `dosages`;

DROP TABLE IF EXISTS `feelings`;
CREATE TABLE `feelings` (
  `feeling_id` int NOT NULL AUTO_INCREMENT,
  `feeling_name` varchar(255) NOT NULL,
  PRIMARY KEY (`feeling_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

TRUNCATE `feelings`;

DROP TABLE IF EXISTS `frequencies`;
CREATE TABLE `frequencies` (
  `frequency_id` int NOT NULL AUTO_INCREMENT,
  `frequency` varchar(255) NOT NULL,
  `repetition` int NOT NULL,
  PRIMARY KEY (`frequency_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

TRUNCATE `frequencies`;

DROP TABLE IF EXISTS `journal_entries`;
CREATE TABLE `journal_entries` (
  `entry_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `timestamp` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `feeling_id` int NOT NULL,
  `details` varchar(255) NOT NULL,
  PRIMARY KEY (`entry_id`),
  KEY `user_info_id` (`user_id`),
  KEY `feeling_id` (`feeling_id`),
  CONSTRAINT `journal_entries_ibfk_2` FOREIGN KEY (`feeling_id`) REFERENCES `feelings` (`feeling_id`) ON DELETE CASCADE,
  CONSTRAINT `journal_entries_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

TRUNCATE `journal_entries`;

DROP TABLE IF EXISTS `take_time_allocation`;
CREATE TABLE `take_time_allocation` (
  `take_time_freq_id` int NOT NULL AUTO_INCREMENT,
  `frequency_id` int NOT NULL,
  `take_time_id` int NOT NULL,
  PRIMARY KEY (`take_time_freq_id`),
  KEY `frequency_id` (`frequency_id`),
  KEY `take_time_id` (`take_time_id`),
  CONSTRAINT `take_time_allocation_ibfk_1` FOREIGN KEY (`frequency_id`) REFERENCES `frequencies` (`frequency_id`) ON DELETE CASCADE,
  CONSTRAINT `take_time_allocation_ibfk_2` FOREIGN KEY (`take_time_id`) REFERENCES `taken_times` (`take_time_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

TRUNCATE `take_time_allocation`;

DROP TABLE IF EXISTS `taken_times`;
CREATE TABLE `taken_times` (
  `take_time_id` int NOT NULL AUTO_INCREMENT,
  `time` time NOT NULL,
  `preference_id` int NOT NULL,
  PRIMARY KEY (`take_time_id`),
  KEY `preference_id` (`preference_id`),
  CONSTRAINT `taken_times_ibfk_1` FOREIGN KEY (`preference_id`) REFERENCES `time_preferences` (`preference_id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

TRUNCATE `taken_times`;

DROP TABLE IF EXISTS `taken_treatment_log`;
CREATE TABLE `taken_treatment_log` (
  `taken_log_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `treatment_id` int NOT NULL,
  `timestamp` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `taken_time` time NOT NULL,
  `taken` varchar(3) NOT NULL,
  PRIMARY KEY (`taken_log_id`),
  KEY `user_info_id` (`user_id`),
  KEY `treatment_id` (`treatment_id`),
  CONSTRAINT `taken_treatment_log_ibfk_2` FOREIGN KEY (`treatment_id`) REFERENCES `treatments` (`treatment_id`),
  CONSTRAINT `taken_treatment_log_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

TRUNCATE `taken_treatment_log`;

DROP TABLE IF EXISTS `time_preferences`;
CREATE TABLE `time_preferences` (
  `preference_id` int NOT NULL AUTO_INCREMENT,
  `preference_type` varchar(255) NOT NULL,
  PRIMARY KEY (`preference_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

TRUNCATE `time_preferences`;

DROP TABLE IF EXISTS `treatments`;
CREATE TABLE `treatments` (
  `treatment_id` int NOT NULL AUTO_INCREMENT,
  `unit_id` int NOT NULL,
  `dosage_id` int NOT NULL,
  `concentration_id` tinyint NOT NULL,
  `frequency_id` int NOT NULL,
  `color` varchar(255) NOT NULL,
  PRIMARY KEY (`treatment_id`),
  KEY `unit_id` (`unit_id`),
  KEY `dosage_id` (`dosage_id`),
  KEY `concentration_id` (`concentration_id`),
  KEY `frequency_id` (`frequency_id`),
  CONSTRAINT `treatments_ibfk_1` FOREIGN KEY (`unit_id`) REFERENCES `units` (`unit_id`) ON DELETE CASCADE,
  CONSTRAINT `treatments_ibfk_2` FOREIGN KEY (`dosage_id`) REFERENCES `dosages` (`dosage_id`) ON DELETE CASCADE,
  CONSTRAINT `treatments_ibfk_3` FOREIGN KEY (`concentration_id`) REFERENCES `concentrations` (`concentration_id`) ON DELETE CASCADE,
  CONSTRAINT `treatments_ibfk_4` FOREIGN KEY (`frequency_id`) REFERENCES `frequencies` (`frequency_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

TRUNCATE `treatments`;

DROP TABLE IF EXISTS `units`;
CREATE TABLE `units` (
  `unit_id` int NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(255) NOT NULL,
  PRIMARY KEY (`unit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

TRUNCATE `units`;

DROP TABLE IF EXISTS `user_accounts`;
CREATE TABLE `user_accounts` (
  `account_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `create_date` date NOT NULL,
  `last_login` timestamp NOT NULL,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

TRUNCATE `user_accounts`;
INSERT INTO `user_accounts` (`account_id`, `email`, `password`, `create_date`, `last_login`) VALUES
(1,	'gigel@email.com',	'sha512',	'2014-03-20',	'2015-03-20 21:00:00');

DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `gender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `caretaker_id` int DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `user_id` (`account_id`),
  KEY `caretaker_id` (`caretaker_id`),
  CONSTRAINT `user_info_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `user_accounts` (`account_id`),
  CONSTRAINT `user_info_ibfk_2` FOREIGN KEY (`caretaker_id`) REFERENCES `caretakers` (`caretaker_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

TRUNCATE `user_info`;
INSERT INTO `user_info` (`user_id`, `account_id`, `name`, `gender`, `birthday`, `caretaker_id`) VALUES
(2,	1,	'Gigel',	'M',	NULL,	NULL);

DROP TABLE IF EXISTS `user_treatment_allocation`;
CREATE TABLE `user_treatment_allocation` (
  `user_treatment_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `treatment_id` int NOT NULL,
  PRIMARY KEY (`user_treatment_id`),
  KEY `user_info_id` (`user_id`),
  KEY `treatment_id` (`treatment_id`),
  CONSTRAINT `user_treatment_allocation_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `user_treatment_allocation_ibfk_2` FOREIGN KEY (`treatment_id`) REFERENCES `treatments` (`treatment_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

TRUNCATE `user_treatment_allocation`;

-- 2021-03-15 14:39:55