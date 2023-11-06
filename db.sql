-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE =
        'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

DROP SCHEMA IF EXISTS `mydb`;
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8;
USE `mydb`;

-- -----------------------------------------------------
-- Table `mydb`.`Smer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Smer`
(
    `smerId` INT         NOT NULL AUTO_INCREMENT,
    `naziv`  VARCHAR(45) NOT NULL,
    PRIMARY KEY (`smerId`)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Drzava`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Drzava`
(
    `drzavaId` INT         NOT NULL AUTO_INCREMENT,
    `naziv`    VARCHAR(45) NOT NULL,
    PRIMARY KEY (`drzavaId`)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Kraj`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Kraj`
(
    `krajId`    INT         NOT NULL AUTO_INCREMENT,
    `naziv`     VARCHAR(45) NOT NULL,
    `Drzava_id` INT         NOT NULL,
    PRIMARY KEY (`krajId`),
    INDEX `fk_Kraj_Drzava1_idx` (`Drzava_id` ASC) VISIBLE,
    CONSTRAINT `fk_Kraj_Drzava1`
        FOREIGN KEY (`Drzava_id`)
            REFERENCES `mydb`.`Drzava` (`drzavaId`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Naslov`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Naslov`
(
    `naslovId` INT         NOT NULL AUTO_INCREMENT,
    `naziv`    VARCHAR(45) NULL,
    `Kraj_id`  INT         NOT NULL,
    PRIMARY KEY (`naslovId`),
    INDEX `fk_Naslov_Kraj1_idx` (`Kraj_id` ASC) VISIBLE,
    CONSTRAINT `fk_Naslov_Kraj1`
        FOREIGN KEY (`Kraj_id`)
            REFERENCES `mydb`.`Kraj` (`krajId`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Student`
(
    `studentId`       INT         NOT NULL AUTO_INCREMENT,
    `vpisna_stevilka` VARCHAR(45) NOT NULL,
    `ime`             VARCHAR(45) NOT NULL,
    `priimek`         VARCHAR(45) NOT NULL,
    `predizobrazba`   VARCHAR(45) NULL,
    `Smer_id`         INT         NOT NULL,
    `Naslov_id`       INT         NOT NULL,
    PRIMARY KEY (`studentId`),
    INDEX `fk_Student_Smer1_idx` (`Smer_id` ASC) VISIBLE,
    INDEX `fk_Student_Naslov1_idx` (`Naslov_id` ASC) VISIBLE,
    CONSTRAINT `fk_Student_Smer1`
        FOREIGN KEY (`Smer_id`)
            REFERENCES `mydb`.`Smer` (`smerId`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_Student_Naslov1`
        FOREIGN KEY (`Naslov_id`)
            REFERENCES `mydb`.`Naslov` (`naslovId`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Predmet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Predmet`
(
    `predmetId` INT          NOT NULL AUTO_INCREMENT,
    `naziv`     VARCHAR(45)  NOT NULL,
    `vsebina`   VARCHAR(200) NOT NULL,
    `Smer_id`   INT          NOT NULL,
    PRIMARY KEY (`predmetId`),
    INDEX `fk_Predmet_Smer1_idx` (`Smer_id` ASC) VISIBLE,
    CONSTRAINT `fk_Predmet_Smer1`
        FOREIGN KEY (`Smer_id`)
            REFERENCES `mydb`.`Smer` (`smerId`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Delavec`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Delavec`
(
    `delavecId` INT         NOT NULL AUTO_INCREMENT,
    `ime`       VARCHAR(45) NOT NULL,
    `priimek`   VARCHAR(45) NOT NULL,
    `Naslov_id` INT         NOT NULL,
    PRIMARY KEY (`delavecId`),
    INDEX `fk_Delavec_Naslov1_idx` (`Naslov_id` ASC) VISIBLE,
    CONSTRAINT `fk_Delavec_Naslov1`
        FOREIGN KEY (`Naslov_id`)
            REFERENCES `mydb`.`Naslov` (`naslovId`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Predmet_Uci_Delavec`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Predmet_Uci_Delavec`
(
    `Predmet_id` INT                                       NOT NULL,
    `Delavec_id` INT                                       NOT NULL,
    `Vloga`      ENUM ("PROFESOR", "ASISTENT", "LABORANT") NOT NULL,
    PRIMARY KEY (`Predmet_id`, `Delavec_id`),
    INDEX `fk_Predmet_has_Delavec_Delavec1_idx` (`Delavec_id` ASC) VISIBLE,
    INDEX `fk_Predmet_has_Delavec_Predmet1_idx` (`Predmet_id` ASC) VISIBLE,
    CONSTRAINT `fk_Predmet_has_Delavec_Predmet1`
        FOREIGN KEY (`Predmet_id`)
            REFERENCES `mydb`.`Predmet` (`predmetId`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_Predmet_has_Delavec_Delavec1`
        FOREIGN KEY (`Delavec_id`)
            REFERENCES `mydb`.`Delavec` (`delavecId`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Naslov`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Naslov`
(
    `naslovId` INT         NOT NULL,
    `naziv`    VARCHAR(45) NULL,
    PRIMARY KEY (`naslovId`)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Vaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Vaje`
(
    `vajeId`     INT         NOT NULL AUTO_INCREMENT,
    `vsebina`    VARCHAR(45) NOT NULL,
    `Predmet_id` INT         NOT NULL,
    PRIMARY KEY (`vajeId`),
    INDEX `fk_Vaje_Predmet1_idx` (`Predmet_id` ASC) VISIBLE,
    CONSTRAINT `fk_Vaje_Predmet1`
        FOREIGN KEY (`Predmet_id`)
            REFERENCES `mydb`.`Predmet` (`predmetId`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Prisotnost`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Prisotnost`
(
    `prisotnostId` INT          NOT NULL AUTO_INCREMENT,
    `Student_id`   INT          NOT NULL,
    `datum`        DATE         NOT NULL,
    `prisoten`     TINYINT      NOT NULL,
    `Vaje_id`      INT          NOT NULL,
    `opravicilo`   VARCHAR(250) NULL,
    PRIMARY KEY (`prisotnostId`, `Student_id`),
    INDEX `fk_Prisotnost_Student1_idx` (`Student_id` ASC) VISIBLE,
    INDEX `fk_Prisotnost_Vaje1_idx` (`Vaje_id` ASC) VISIBLE,
    CONSTRAINT `fk_Prisotnost_Student1`
        FOREIGN KEY (`Student_id`)
            REFERENCES `mydb`.`Student` (`studentId`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_Prisotnost_Vaje1`
        FOREIGN KEY (`Vaje_id`)
            REFERENCES `mydb`.`Vaje` (`vajeId`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ocena_Vaj`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ocena_Vaj`
(
    `ocenaVajId` INT    NOT NULL AUTO_INCREMENT,
    `Student_id` INT    NOT NULL,
    `ocena`      DOUBLE NOT NULL,
    `datum`      DATE   NOT NULL,
    `Vaje_id`    INT    NOT NULL,
    PRIMARY KEY (`ocenaVajId`),
    INDEX `fk_Ocena_Vaj_Student1_idx` (`Student_id` ASC) VISIBLE,
    INDEX `fk_Ocena_Vaj_Vaje1_idx` (`Vaje_id` ASC) VISIBLE,
    CONSTRAINT `fk_Ocena_Vaj_Student1`
        FOREIGN KEY (`Student_id`)
            REFERENCES `mydb`.`Student` (`studentId`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_Ocena_Vaj_Vaje1`
        FOREIGN KEY (`Vaje_id`)
            REFERENCES `mydb`.`Vaje` (`vajeId`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Student_Obiskuje_Predmet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Student_Obiskuje_Predmet`
(
    `Student_id` INT  NOT NULL,
    `Predmet_id` INT  NOT NULL,
    `datum`      DATE NULL,
    PRIMARY KEY (`Student_id`, `Predmet_id`),
    INDEX `fk_Student_has_Predmet_Predmet1_idx` (`Predmet_id` ASC) VISIBLE,
    INDEX `fk_Student_has_Predmet_Student1_idx` (`Student_id` ASC) VISIBLE,
    CONSTRAINT `fk_Student_has_Predmet_Student1`
        FOREIGN KEY (`Student_id`)
            REFERENCES `mydb`.`Student` (`studentId`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_Student_has_Predmet_Predmet1`
        FOREIGN KEY (`Predmet_id`)
            REFERENCES `mydb`.`Predmet` (`predmetId`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;
