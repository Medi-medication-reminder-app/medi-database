-- Adminer 4.8.0 MySQL 8.0.23 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;

SET NAMES utf8mb4;

DROP DATABASE IF EXISTS `mediusers`;
CREATE DATABASE `mediusers` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mediusers`;

DROP TABLE IF EXISTS `Concentrations`;
CREATE TABLE `Concentrations` (
  `concentration_id` tinyint NOT NULL AUTO_INCREMENT,
  `concentration_amount` varchar(255) NOT NULL,
  PRIMARY KEY (`concentration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `Conditions`;
CREATE TABLE `Conditions` (
  `condition_id` int NOT NULL AUTO_INCREMENT,
  `condition_name` varchar(255) NOT NULL,
  `condition_details` varchar(255) NOT NULL,
  `user_info_id` int NOT NULL,
  PRIMARY KEY (`condition_id`),
  KEY `user_info_id` (`user_info_id`),
  CONSTRAINT `Conditions_ibfk_1` FOREIGN KEY (`user_info_id`) REFERENCES `UserInfo` (`user_info_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `Dosages`;
CREATE TABLE `Dosages` (
  `dosage_id` int NOT NULL AUTO_INCREMENT,
  `dosage_type` varchar(255) NOT NULL,
  PRIMARY KEY (`dosage_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `Feelings`;
CREATE TABLE `Feelings` (
  `feeling_id` int NOT NULL AUTO_INCREMENT,
  `feeling_name` varchar(255) NOT NULL,
  PRIMARY KEY (`feeling_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `Frequency`;
CREATE TABLE `Frequency` (
  `frequency_id` int NOT NULL AUTO_INCREMENT,
  `frequency` varchar(255) NOT NULL,
  `repetition` int NOT NULL,
  PRIMARY KEY (`frequency_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `JournalEntries`;
CREATE TABLE `JournalEntries` (
  `entry_id` int NOT NULL AUTO_INCREMENT,
  `user_info_id` int NOT NULL,
  `timestamp` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `feeling_id` int NOT NULL,
  `details` varchar(255) NOT NULL,
  PRIMARY KEY (`entry_id`),
  KEY `user_info_id` (`user_info_id`),
  KEY `feeling_id` (`feeling_id`),
  CONSTRAINT `JournalEntries_ibfk_1` FOREIGN KEY (`user_info_id`) REFERENCES `UserInfo` (`user_info_id`) ON DELETE CASCADE,
  CONSTRAINT `JournalEntries_ibfk_2` FOREIGN KEY (`feeling_id`) REFERENCES `Feelings` (`feeling_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `TakeTimeAllocation`;
CREATE TABLE `TakeTimeAllocation` (
  `take_time_freq_id` int NOT NULL AUTO_INCREMENT,
  `frequency_id` int NOT NULL,
  `take_time_id` int NOT NULL,
  PRIMARY KEY (`take_time_freq_id`),
  KEY `frequency_id` (`frequency_id`),
  KEY `take_time_id` (`take_time_id`),
  CONSTRAINT `TakeTimeAllocation_ibfk_1` FOREIGN KEY (`frequency_id`) REFERENCES `Frequency` (`frequency_id`) ON DELETE CASCADE,
  CONSTRAINT `TakeTimeAllocation_ibfk_2` FOREIGN KEY (`take_time_id`) REFERENCES `TakenTimes` (`take_time_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `TakenTimes`;
CREATE TABLE `TakenTimes` (
  `take_time_id` int NOT NULL AUTO_INCREMENT,
  `time` time NOT NULL,
  `preference_id` int NOT NULL,
  PRIMARY KEY (`take_time_id`),
  KEY `preference_id` (`preference_id`),
  CONSTRAINT `TakenTimes_ibfk_1` FOREIGN KEY (`preference_id`) REFERENCES `TimePreferences` (`preference_id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `TakenTreatmentLog`;
CREATE TABLE `TakenTreatmentLog` (
  `taken_log_id` int NOT NULL AUTO_INCREMENT,
  `user_info_id` int NOT NULL,
  `treatment_id` int NOT NULL,
  `timestamp` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `taken_time` time NOT NULL,
  `taken` varchar(3) NOT NULL,
  PRIMARY KEY (`taken_log_id`),
  KEY `user_info_id` (`user_info_id`),
  KEY `treatment_id` (`treatment_id`),
  CONSTRAINT `TakenTreatmentLog_ibfk_1` FOREIGN KEY (`user_info_id`) REFERENCES `UserInfo` (`user_info_id`) ON DELETE CASCADE,
  CONSTRAINT `TakenTreatmentLog_ibfk_2` FOREIGN KEY (`treatment_id`) REFERENCES `Treatments` (`treatment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `TimePreferences`;
CREATE TABLE `TimePreferences` (
  `preference_id` int NOT NULL AUTO_INCREMENT,
  `preference_type` varchar(255) NOT NULL,
  PRIMARY KEY (`preference_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `Treatments`;
CREATE TABLE `Treatments` (
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
  CONSTRAINT `Treatments_ibfk_1` FOREIGN KEY (`unit_id`) REFERENCES `Units` (`unit_id`) ON DELETE CASCADE,
  CONSTRAINT `Treatments_ibfk_2` FOREIGN KEY (`dosage_id`) REFERENCES `Dosages` (`dosage_id`) ON DELETE CASCADE,
  CONSTRAINT `Treatments_ibfk_3` FOREIGN KEY (`concentration_id`) REFERENCES `Concentrations` (`concentration_id`) ON DELETE CASCADE,
  CONSTRAINT `Treatments_ibfk_4` FOREIGN KEY (`frequency_id`) REFERENCES `Frequency` (`frequency_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `Units`;
CREATE TABLE `Units` (
  `unit_id` int NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(255) NOT NULL,
  PRIMARY KEY (`unit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `UserAccounts`;
CREATE TABLE `UserAccounts` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `create_date` date NOT NULL,
  `last_login` timestamp NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `UserInfo`;
CREATE TABLE `UserInfo` (
  `user_info_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `birthday` date NOT NULL,
  PRIMARY KEY (`user_info_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `UserInfo_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `UserAccounts` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `UserTreatmentAllocation`;
CREATE TABLE `UserTreatmentAllocation` (
  `user_treatment_id` int NOT NULL AUTO_INCREMENT,
  `user_info_id` int NOT NULL,
  `treatment_id` int NOT NULL,
  PRIMARY KEY (`user_treatment_id`),
  KEY `user_info_id` (`user_info_id`),
  KEY `treatment_id` (`treatment_id`),
  CONSTRAINT `UserTreatmentAllocation_ibfk_1` FOREIGN KEY (`user_info_id`) REFERENCES `UserInfo` (`user_info_id`) ON DELETE CASCADE,
  CONSTRAINT `UserTreatmentAllocation_ibfk_2` FOREIGN KEY (`treatment_id`) REFERENCES `Treatments` (`treatment_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- 2021-03-12 18:07:17