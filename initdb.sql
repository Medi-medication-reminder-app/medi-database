-- Adminer 4.8.0 MySQL 5.7.33 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP DATABASE IF EXISTS `mediusers`;
CREATE DATABASE `mediusers` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `mediusers`;

DROP TABLE IF EXISTS `caretakers`;
CREATE TABLE `caretakers` (
  `caretaker_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone_number` int(11) NOT NULL,
  PRIMARY KEY (`caretaker_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `caretakers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

TRUNCATE `caretakers`;
INSERT INTO `caretakers` (`caretaker_id`, `user_id`, `name`, `phone_number`) VALUES
(1,	4,	'mama la dorel',	741414414);

DROP TABLE IF EXISTS `concentrations`;
CREATE TABLE `concentrations` (
  `concentration_id` int(11) NOT NULL AUTO_INCREMENT,
  `concentration_amount` varchar(255) NOT NULL,
  PRIMARY KEY (`concentration_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

TRUNCATE `concentrations`;
INSERT INTO `concentrations` (`concentration_id`, `concentration_amount`) VALUES
(1,	'g/ml'),
(2,	'ml/g');

DROP TABLE IF EXISTS `conditions`;
CREATE TABLE `conditions` (
  `condition_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `condition_name` varchar(255) NOT NULL,
  `condition_details` varchar(255) NOT NULL,
  PRIMARY KEY (`condition_id`),
  KEY `user_info_id` (`user_id`),
  CONSTRAINT `conditions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

TRUNCATE `conditions`;

DROP TABLE IF EXISTS `dosages`;
CREATE TABLE `dosages` (
  `dosage_id` int(11) NOT NULL AUTO_INCREMENT,
  `dosage_type` varchar(255) NOT NULL,
  PRIMARY KEY (`dosage_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

TRUNCATE `dosages`;
INSERT INTO `dosages` (`dosage_id`, `dosage_type`) VALUES
(1,	'1/3');

DROP TABLE IF EXISTS `feelings`;
CREATE TABLE `feelings` (
  `feeling_id` int(11) NOT NULL AUTO_INCREMENT,
  `feeling_name` varchar(255) NOT NULL,
  PRIMARY KEY (`feeling_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

TRUNCATE `feelings`;
INSERT INTO `feelings` (`feeling_id`, `feeling_name`) VALUES
(1,	'Sickness'),
(2,	'Dizziness'),
(3,	'Pain');

DROP TABLE IF EXISTS `journal_entries`;
CREATE TABLE `journal_entries` (
  `entry_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `feeling_id` int(11) NOT NULL,
  `details` varchar(255) NOT NULL,
  PRIMARY KEY (`entry_id`),
  KEY `user_info_id` (`user_id`),
  KEY `feeling_id` (`feeling_id`),
  CONSTRAINT `journal_entries_ibfk_2` FOREIGN KEY (`feeling_id`) REFERENCES `feelings` (`feeling_id`) ON DELETE CASCADE,
  CONSTRAINT `journal_entries_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

TRUNCATE `journal_entries`;
INSERT INTO `journal_entries` (`entry_id`, `user_id`, `timestamp`, `feeling_id`, `details`) VALUES
(1,	4,	'2021-05-10 10:07:55',	2,	'after 30 min of taking treatment, the room started spinning'),
(2,	4,	'2021-05-10 10:17:33',	3,	'<insert DOOM music here>');

DROP TABLE IF EXISTS `taken_treatment_log`;
CREATE TABLE `taken_treatment_log` (
  `taken_log_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `treatment_id` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `taken_time` time NOT NULL,
  `taken` varchar(3) NOT NULL,
  PRIMARY KEY (`taken_log_id`),
  KEY `user_info_id` (`user_id`),
  KEY `treatment_id` (`treatment_id`),
  CONSTRAINT `taken_treatment_log_ibfk_2` FOREIGN KEY (`treatment_id`) REFERENCES `treatments` (`treatment_id`),
  CONSTRAINT `taken_treatment_log_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

TRUNCATE `taken_treatment_log`;
INSERT INTO `taken_treatment_log` (`taken_log_id`, `user_id`, `treatment_id`, `timestamp`, `taken_time`, `taken`) VALUES
(3,	4,	1,	'2021-04-22 13:46:55',	'19:36:57',	'NO'),
(4,	4,	1,	'2021-04-22 13:47:09',	'19:36:58',	'NO'),
(5,	4,	2,	'2021-04-22 13:48:56',	'23:37:54',	'YES'),
(7,	4,	2,	'2021-05-10 08:19:51',	'23:37:54',	'YES');

DROP TABLE IF EXISTS `take_times`;
CREATE TABLE `take_times` (
  `take_time_id` int(11) NOT NULL AUTO_INCREMENT,
  `treatment_id` int(11) NOT NULL,
  `time` time NOT NULL,
  `day` varchar(255) NOT NULL,
  `preference_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`take_time_id`),
  KEY `preference_id` (`preference_id`),
  KEY `treatment_id` (`treatment_id`),
  CONSTRAINT `take_times_ibfk_1` FOREIGN KEY (`preference_id`) REFERENCES `time_preferences` (`preference_id`),
  CONSTRAINT `take_times_ibfk_2` FOREIGN KEY (`treatment_id`) REFERENCES `treatments` (`treatment_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

TRUNCATE `take_times`;
INSERT INTO `take_times` (`take_time_id`, `treatment_id`, `time`, `day`, `preference_id`) VALUES
(18,	2,	'23:37:54',	'Thursday',	NULL),
(19,	1,	'19:36:58',	'Everyday',	1),
(20,	1,	'19:37:11',	'Sunday',	NULL),
(21,	1,	'19:37:54',	'Sunday',	NULL),
(22,	1,	'23:37:54',	'Thursday',	NULL);

DROP TABLE IF EXISTS `time_preferences`;
CREATE TABLE `time_preferences` (
  `preference_id` int(11) NOT NULL AUTO_INCREMENT,
  `preference_type` varchar(255) NOT NULL,
  PRIMARY KEY (`preference_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

TRUNCATE `time_preferences`;
INSERT INTO `time_preferences` (`preference_id`, `preference_type`) VALUES
(1,	'after lunch');

DROP TABLE IF EXISTS `treatments`;
CREATE TABLE `treatments` (
  `treatment_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `dosage_id` int(11) NOT NULL,
  `concentration_id` int(11) NOT NULL,
  `frequency` int(11) NOT NULL,
  `color` varchar(255) NOT NULL,
  PRIMARY KEY (`treatment_id`),
  UNIQUE KEY `name` (`name`),
  KEY `unit_id` (`unit_id`),
  KEY `dosage_id` (`dosage_id`),
  KEY `concentration_id` (`concentration_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `treatments_ibfk_1` FOREIGN KEY (`unit_id`) REFERENCES `units` (`unit_id`) ON DELETE CASCADE,
  CONSTRAINT `treatments_ibfk_2` FOREIGN KEY (`dosage_id`) REFERENCES `dosages` (`dosage_id`) ON DELETE CASCADE,
  CONSTRAINT `treatments_ibfk_3` FOREIGN KEY (`concentration_id`) REFERENCES `concentrations` (`concentration_id`) ON DELETE CASCADE,
  CONSTRAINT `treatments_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

TRUNCATE `treatments`;
INSERT INTO `treatments` (`treatment_id`, `user_id`, `name`, `unit_id`, `dosage_id`, `concentration_id`, `frequency`, `color`) VALUES
(1,	4,	'Melatonin',	1,	1,	1,	9999,	'FFEE02'),
(2,	4,	'Rivaroxaban',	1,	1,	1,	9999,	'FFEE02');

DROP TABLE IF EXISTS `units`;
CREATE TABLE `units` (
  `unit_id` int(11) NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(255) NOT NULL,
  PRIMARY KEY (`unit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

TRUNCATE `units`;
INSERT INTO `units` (`unit_id`, `unit_name`) VALUES
(1,	'capsule');

DROP TABLE IF EXISTS `user_accounts`;
CREATE TABLE `user_accounts` (
  `account_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `create_date` date NOT NULL,
  `last_login` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

TRUNCATE `user_accounts`;
INSERT INTO `user_accounts` (`account_id`, `email`, `password`, `create_date`, `last_login`) VALUES
(1,	'gigel@email.com',	'sha512',	'2014-03-20',	'2015-03-20 21:00:00'),
(2,	'drojdel@beabere.ro',	'abcd',	'2021-03-18',	'2021-03-18 15:33:11'),
(3,	'dorel@sapogropa.ro',	'abcd',	'2021-04-21',	'2021-04-21 12:11:13'),
(4,	'flavia@email.com',	'parola',	'2021-04-21',	'2021-04-21 12:32:55'),
(6,	'flaviuta@email.com',	'parola',	'2021-04-21',	'2021-04-21 12:36:55'),
(7,	'flavi@email.com',	'parola',	'2021-04-21',	'2021-04-21 12:39:39');

DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `user_id` (`account_id`),
  CONSTRAINT `user_info_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `user_accounts` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

TRUNCATE `user_info`;
INSERT INTO `user_info` (`user_id`, `account_id`, `name`, `gender`, `birthday`) VALUES
(2,	1,	'Gigel',	'M',	NULL),
(3,	2,	'Drojdel',	NULL,	NULL),
(4,	3,	'Dorel',	'male',	NULL),
(5,	4,	NULL,	NULL,	NULL),
(6,	6,	NULL,	NULL,	NULL),
(7,	7,	NULL,	NULL,	NULL);

-- 2021-05-11 11:07:52