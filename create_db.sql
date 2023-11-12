USE mydb;

-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.31

SET foreign_key_checks = 0;
/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS = @@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION = @@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE = @@TIME_ZONE */;
/*!40103 SET TIME_ZONE = '+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0 */;
/*!40101 SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES = @@SQL_NOTES, SQL_NOTES = 0 */;

--
-- Table structure for table `delavec`
--

DROP TABLE IF EXISTS `delavec`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delavec`
(
    `delavecId` int         NOT NULL AUTO_INCREMENT,
    `ime`       varchar(45) NOT NULL,
    `priimek`   varchar(45) NOT NULL,
    `Naslov_id` int         NOT NULL,
    PRIMARY KEY (`delavecId`),
    KEY `fk_Delavec_Naslov1_idx` (`Naslov_id`),
    CONSTRAINT `fk_Delavec_Naslov1` FOREIGN KEY (`Naslov_id`) REFERENCES `naslov` (`naslovId`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drzava`
--

DROP TABLE IF EXISTS `drzava`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drzava`
(
    `drzavaId` int         NOT NULL AUTO_INCREMENT,
    `naziv`    varchar(45) NOT NULL,
    PRIMARY KEY (`drzavaId`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1000001
  DEFAULT CHARSET = utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kraj`
--

DROP TABLE IF EXISTS `kraj`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kraj`
(
    `krajId`    int         NOT NULL AUTO_INCREMENT,
    `naziv`     varchar(45) NOT NULL,
    `Drzava_id` int         NOT NULL,
    PRIMARY KEY (`krajId`),
    KEY `fk_Kraj_Drzava1_idx` (`Drzava_id`),
    CONSTRAINT `fk_Kraj_Drzava1` FOREIGN KEY (`Drzava_id`) REFERENCES `drzava` (`drzavaId`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1000001
  DEFAULT CHARSET = utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `naslov`
--

DROP TABLE IF EXISTS `naslov`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `naslov`
(
    `naslovId` int NOT NULL AUTO_INCREMENT,
    `naziv`    varchar(45) DEFAULT NULL,
    `Kraj_id`  int NOT NULL,
    PRIMARY KEY (`naslovId`),
    KEY `fk_Naslov_Kraj1_idx` (`Kraj_id`),
    CONSTRAINT `fk_Naslov_Kraj1` FOREIGN KEY (`Kraj_id`) REFERENCES `kraj` (`krajId`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1000001
  DEFAULT CHARSET = utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ocena_vaj`
--

DROP TABLE IF EXISTS `ocena_vaj`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ocena_vaj`
(
    `ocenaVajId` int    NOT NULL AUTO_INCREMENT,
    `Student_id` int    NOT NULL,
    `ocena`      double NOT NULL,
    `datum`      date   NOT NULL,
    `Vaje_id`    int    NOT NULL,
    PRIMARY KEY (`ocenaVajId`),
    KEY `fk_Ocena_Vaj_Student1_idx` (`Student_id`),
    KEY `fk_Ocena_Vaj_Vaje1_idx` (`Vaje_id`),
    CONSTRAINT `fk_Ocena_Vaj_Student1` FOREIGN KEY (`Student_id`) REFERENCES `student` (`studentId`),
    CONSTRAINT `fk_Ocena_Vaj_Vaje1` FOREIGN KEY (`Vaje_id`) REFERENCES `vaje` (`vajeId`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `predmet`
--

DROP TABLE IF EXISTS `predmet`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `predmet`
(
    `predmetId` int          NOT NULL AUTO_INCREMENT,
    `naziv`     varchar(45)  NOT NULL,
    `vsebina`   varchar(200) NOT NULL,
    `Smer_id`   int          NOT NULL,
    PRIMARY KEY (`predmetId`),
    KEY `fk_Predmet_Smer1_idx` (`Smer_id`),
    CONSTRAINT `fk_Predmet_Smer1` FOREIGN KEY (`Smer_id`) REFERENCES `smer` (`smerId`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `predmet_uci_delavec`
--

DROP TABLE IF EXISTS `predmet_uci_delavec`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `predmet_uci_delavec`
(
    `Predmet_id` int                                     NOT NULL,
    `Delavec_id` int                                     NOT NULL,
    `Vloga`      enum ('PROFESOR','ASISTENT','LABORANT') NOT NULL,
    PRIMARY KEY (`Predmet_id`, `Delavec_id`),
    KEY `fk_Predmet_has_Delavec_Delavec1_idx` (`Delavec_id`),
    KEY `fk_Predmet_has_Delavec_Predmet1_idx` (`Predmet_id`),
    CONSTRAINT `fk_Predmet_has_Delavec_Delavec1` FOREIGN KEY (`Delavec_id`) REFERENCES `delavec` (`delavecId`),
    CONSTRAINT `fk_Predmet_has_Delavec_Predmet1` FOREIGN KEY (`Predmet_id`) REFERENCES `predmet` (`predmetId`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prisotnost`
--

DROP TABLE IF EXISTS `prisotnost`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prisotnost`
(
    `prisotnostId` int     NOT NULL AUTO_INCREMENT,
    `Student_id`   int     NOT NULL,
    `datum`        date    NOT NULL,
    `prisoten`     tinyint NOT NULL,
    `Vaje_id`      int     NOT NULL,
    `opravicilo`   varchar(250) DEFAULT NULL,
    PRIMARY KEY (`prisotnostId`, `Student_id`),
    KEY `fk_Prisotnost_Student1_idx` (`Student_id`),
    KEY `fk_Prisotnost_Vaje1_idx` (`Vaje_id`),
    CONSTRAINT `fk_Prisotnost_Student1` FOREIGN KEY (`Student_id`) REFERENCES `student` (`studentId`),
    CONSTRAINT `fk_Prisotnost_Vaje1` FOREIGN KEY (`Vaje_id`) REFERENCES `vaje` (`vajeId`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `smer`
--

DROP TABLE IF EXISTS `smer`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `smer`
(
    `smerId`     int         NOT NULL AUTO_INCREMENT,
    `naziv`      varchar(45) NOT NULL,
    `opis`       varchar(50),
    `created_at` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` datetime             DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`smerId`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1000001
  DEFAULT CHARSET = utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student`
(
    `studentId`       int         NOT NULL AUTO_INCREMENT,
    `vpisna_stevilka` varchar(45) NOT NULL,
    `ime`             varchar(45) NOT NULL,
    `priimek`         varchar(45) NOT NULL,
    `predizobrazba`   varchar(45) DEFAULT NULL,
    `Smer_id`         int         NOT NULL,
    `Naslov_id`       int         NOT NULL,
    PRIMARY KEY (`studentId`),
    KEY `fk_Student_Smer1_idx` (`Smer_id`),
    KEY `fk_Student_Naslov1_idx` (`Naslov_id`),
    CONSTRAINT `fk_Student_Naslov1` FOREIGN KEY (`Naslov_id`) REFERENCES `naslov` (`naslovId`),
    CONSTRAINT `fk_Student_Smer1` FOREIGN KEY (`Smer_id`) REFERENCES `smer` (`smerId`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1000001
  DEFAULT CHARSET = utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `student_obiskuje_predmet`
--

DROP TABLE IF EXISTS `student_obiskuje_predmet`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_obiskuje_predmet`
(
    `Student_id` int NOT NULL,
    `Predmet_id` int NOT NULL,
    `datum`      date DEFAULT NULL,
    PRIMARY KEY (`Student_id`, `Predmet_id`),
    KEY `fk_Student_has_Predmet_Predmet1_idx` (`Predmet_id`),
    KEY `fk_Student_has_Predmet_Student1_idx` (`Student_id`),
    CONSTRAINT `fk_Student_has_Predmet_Predmet1` FOREIGN KEY (`Predmet_id`) REFERENCES `predmet` (`predmetId`),
    CONSTRAINT `fk_Student_has_Predmet_Student1` FOREIGN KEY (`Student_id`) REFERENCES `student` (`studentId`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vaje`
--

DROP TABLE IF EXISTS `vaje`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vaje`
(
    `vajeId`     int         NOT NULL AUTO_INCREMENT,
    `vsebina`    varchar(45) NOT NULL,
    `Predmet_id` int         NOT NULL,
    PRIMARY KEY (`vajeId`),
    KEY `fk_Vaje_Predmet1_idx` (`Predmet_id`),
    CONSTRAINT `fk_Vaje_Predmet1` FOREIGN KEY (`Predmet_id`) REFERENCES `predmet` (`predmetId`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE = @OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE = @OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS = @OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION = @OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES = @OLD_SQL_NOTES */;

-- Dump completed on 2023-11-06 23:46:22
SET foreign_key_checks = 1;
