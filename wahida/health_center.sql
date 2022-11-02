-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 02. Nov 2022 um 13:34
-- Server-Version: 10.4.25-MariaDB
-- PHP-Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `health_center`
--
CREATE DATABASE IF NOT EXISTS `health_center` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `health_center`;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `doctor`
--

CREATE TABLE `doctor` (
  `doctor_id` int(11) NOT NULL,
  `doctor_code` varchar(50) NOT NULL,
  `doctor_speciality` varchar(50) NOT NULL,
  `fk_intervention_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `doctor`
--

INSERT INTO `doctor` (`doctor_id`, `doctor_code`, `doctor_speciality`, `fk_intervention_id`) VALUES
(1, '001', 'Hausarzt', 2);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `health_center`
--

CREATE TABLE `health_center` (
  `health_center_id` int(11) NOT NULL,
  `fk_unit_id` int(11) NOT NULL,
  `fk_patient_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `intervention`
--

CREATE TABLE `intervention` (
  `intervention_id` int(11) NOT NULL,
  `intervention_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `intervention_treatment` varchar(50) NOT NULL,
  `intervention_symptom` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `intervention`
--

INSERT INTO `intervention` (`intervention_id`, `intervention_date`, `intervention_treatment`, `intervention_symptom`) VALUES
(1, '2022-11-02 11:56:46', 'kontrolle', 'husten'),
(2, '2022-11-02 11:57:27', 'kontrolle', 'schnupfen');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `patient`
--

CREATE TABLE `patient` (
  `patient_id` int(11) NOT NULL,
  `patient_svnumber` varchar(11) NOT NULL,
  `patient_age` varchar(2) NOT NULL,
  `patient_email` varchar(50) NOT NULL,
  `patient_dateAdmission` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `patient`
--

INSERT INTO `patient` (`patient_id`, `patient_svnumber`, `patient_age`, `patient_email`, `patient_dateAdmission`) VALUES
(5, '56432897653', '23', 'max@yahoo.com', '2022-11-02 12:24:52.022663'),
(6, '7865490715', '45', 'rubi@hotmail.com', '2022-11-02 12:26:19.350958');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `unit`
--

CREATE TABLE `unit` (
  `unit_id` int(11) NOT NULL,
  `unit_name` varchar(50) NOT NULL,
  `unit_floor` varchar(50) NOT NULL,
  `fk_doctor_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`doctor_id`),
  ADD KEY `fk_intervention_id` (`fk_intervention_id`);

--
-- Indizes für die Tabelle `health_center`
--
ALTER TABLE `health_center`
  ADD PRIMARY KEY (`health_center_id`),
  ADD KEY `fk_unit_id` (`fk_unit_id`),
  ADD KEY `fk_patient_id` (`fk_patient_id`);

--
-- Indizes für die Tabelle `intervention`
--
ALTER TABLE `intervention`
  ADD PRIMARY KEY (`intervention_id`);

--
-- Indizes für die Tabelle `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`patient_id`),
  ADD UNIQUE KEY `patient_email` (`patient_email`);

--
-- Indizes für die Tabelle `unit`
--
ALTER TABLE `unit`
  ADD PRIMARY KEY (`unit_id`),
  ADD KEY `fk_doctor_id` (`fk_doctor_id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `doctor`
--
ALTER TABLE `doctor`
  MODIFY `doctor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT für Tabelle `health_center`
--
ALTER TABLE `health_center`
  MODIFY `health_center_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `intervention`
--
ALTER TABLE `intervention`
  MODIFY `intervention_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `patient`
--
ALTER TABLE `patient`
  MODIFY `patient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT für Tabelle `unit`
--
ALTER TABLE `unit`
  MODIFY `unit_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `doctor`
--
ALTER TABLE `doctor`
  ADD CONSTRAINT `doctor_ibfk_1` FOREIGN KEY (`fk_intervention_id`) REFERENCES `intervention` (`intervention_id`);

--
-- Constraints der Tabelle `health_center`
--
ALTER TABLE `health_center`
  ADD CONSTRAINT `health_center_ibfk_1` FOREIGN KEY (`fk_unit_id`) REFERENCES `unit` (`unit_id`),
  ADD CONSTRAINT `health_center_ibfk_2` FOREIGN KEY (`fk_patient_id`) REFERENCES `patient` (`patient_id`);

--
-- Constraints der Tabelle `unit`
--
ALTER TABLE `unit`
  ADD CONSTRAINT `unit_ibfk_1` FOREIGN KEY (`fk_doctor_id`) REFERENCES `doctor` (`doctor_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
