use mydb;

DROP PROCEDURE IF EXISTS NAPOLNI_DRZAVO;
DROP PROCEDURE IF EXISTS NAPOLNI_SMER;
DROP PROCEDURE IF EXISTS NAPOLNI_KRAJ;
DROP PROCEDURE IF EXISTS NAPOLNI_NASLOV;
DROP PROCEDURE IF EXISTS NAPOLNI_DELAVEC;
DROP PROCEDURE IF EXISTS NAPOLNI_PREDMET;
DROP PROCEDURE IF EXISTS NAPOLNI_STUDENT;
DROP PROCEDURE IF EXISTS NAPOLNI_VAJE;
DROP PROCEDURE IF EXISTS NAPOLNI_STUDENT_PREDMET;
DROP PROCEDURE IF EXISTS NAPOLNI_PREDMET_DELAVEC;
DROP PROCEDURE IF EXISTS NAPOLNI_PRISOTNOST;
DROP PROCEDURE IF EXISTS NAPOLNI_OCENE;

SET foreign_key_checks = 0;

TRUNCATE TABLE kraj;
TRUNCATE TABLE drzava;
TRUNCATE TABLE naslov;
TRUNCATE TABLE predmet;
TRUNCATE TABLE smer;
TRUNCATE TABLE delavec;
TRUNCATE TABLE student;
TRUNCATE TABLE vaje;
TRUNCATE TABLE student_obiskuje_predmet;
TRUNCATE TABLE predmet_uci_delavec;
TRUNCATE TABLE prisotnost;
TRUNCATE TABLE ocena_vaj;

SET foreign_key_checks = 1;

DELIMITER //

create procedure NAPOLNI_DRZAVO(in rc int)
begin
    DECLARE i int;
    SET i = 0;
    WHILE i < rc
        DO
            INSERT INTO drzava(naziv) VALUES (concat('drzava-', i));
            SET i = i + 1;
        END WHILE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE NAPOLNI_SMER(in rc int)
BEGIN
    DECLARE i int;
    SET i = 0;
    WHILE i < rc
        DO
            INSERT INTO smer(naziv) VALUES (concat('smer-', i));
            SET i = i + 1;
        END WHILE;

END //

DELIMITER //

CREATE PROCEDURE NAPOLNI_KRAJ(in rc int)
BEGIN
    DECLARE d INT DEFAULT 0;
    DECLARE d_id INT;
    DECLARE d_naziv VARCHAR(40);

    DECLARE d_cur CURSOR FOR SELECT * FROM drzava order by rand() limit rc;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'
        SET d = 1;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '23000'
        SET d = 1;

    OPEN d_cur;
    FETCH d_cur INTO d_id, d_naziv;

    loop_lbl:
    LOOP
        IF d = 1 THEN
            LEAVE loop_lbl;
        END IF;
        IF NOT d = 1 THEN
            INSERT INTO kraj (naziv, drzava_id) VALUES (concat('Kraj drzave ', d_naziv), d_id);
            FETCH d_cur INTO d_id, d_naziv;
        END IF;
    END LOOP;
    CLOSE d_cur;

END;
//
DELIMITER ;

DELIMITER //

CREATE PROCEDURE NAPOLNI_NASLOV(in rc int)

BEGIN
    DECLARE d INT default 0;
    DECLARE kraj_id INT;
    DECLARE kraj_naziv VARCHAR(45);
    DECLARE kraj_drzava_id INT;
    DECLARE k_cur CURSOR FOR SELECT * FROM kraj order by rand() limit rc;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'
        SET d = 1;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '23000'
        SET d = 1;

    OPEN k_cur;
    FETCH k_cur INTO kraj_id, kraj_naziv, kraj_drzava_id;

    loop_lbl:
    LOOP
        IF d = 1 THEN
            LEAVE loop_lbl;
        END IF;
        IF NOT d = 1 THEN
            INSERT INTO naslov (naziv, Kraj_id) VALUES (concat('Naslov za kraj ', kraj_naziv), kraj_id);
            FETCH k_cur INTO kraj_id, kraj_naziv, kraj_drzava_id;
        END IF;
    END LOOP;
    CLOSE k_cur;
END;
//

DELIMITER //

CREATE PROCEDURE NAPOLNI_DELAVEC(in rc int)

BEGIN
    DECLARE delavecIndex int DEFAULT 0;
    DECLARE d INT default 0;

    DECLARE naslov_id INT;
    DECLARE naslov_naziv VARCHAR(45);
    DECLARE naslov_kraj_id int;
    DECLARE naslov_cur CURSOR FOR SELECT * FROM naslov order by rand() limit rc;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'
        SET d = 1;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '23000'
        SET d = 1;

    OPEN naslov_cur;
    FETCH naslov_cur INTO naslov_id, naslov_naziv, naslov_kraj_id;

    loop_lbl:
    LOOP
        IF d = 1 THEN
            LEAVE loop_lbl;
        END IF;
        IF NOT d = 1 THEN
            INSERT INTO delavec(ime, priimek, Naslov_id)
            VALUES (concat('Delavec ', delavecIndex), concat('Priimek ', delavecIndex), naslov_id);
            SET delavecIndex = delavecIndex + 1;
            FETCH naslov_cur INTO naslov_id, naslov_naziv, naslov_kraj_id;

        END IF;
    END LOOP;
    CLOSE naslov_cur;

END;
//

DELIMITER //
CREATE PROCEDURE NAPOLNI_PREDMET(in rc int)
BEGIN
    DECLARE predmetIndex int DEFAULT 0;
    DECLARE d INT default 0;

    DECLARE smer_id INT;
    DECLARE smer_naziv varchar(45);

    DECLARE smer_cur CURSOR FOR SELECT * FROM smer order by rand() limit rc;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'
        SET d = 1;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '23000'
        SET d = 1;
    OPEN smer_cur;
    FETCH smer_cur INTO smer_id, smer_naziv;

    loop_lbl:
    LOOP
        IF d = 1 THEN
            LEAVE loop_lbl;
        END IF;
        IF NOT d = 1 THEN
            INSERT INTO predmet(naziv, vsebina, Smer_id)
            VALUES (concat('Predmet ', predmetIndex),
                    concat('Vsebina predmeta ', predmetIndex, ' za smer ', smer_naziv), smer_id);
            SET predmetIndex = predmetIndex + 1;
            FETCH smer_cur INTO smer_id, smer_naziv;

        END IF;
    END LOOP;
    CLOSE smer_cur;

END;
//

DELIMITER //
CREATE PROCEDURE NAPOLNI_STUDENT(in rc_n int)
BEGIN
    DECLARE studentIndex INT default 1;

    DECLARE d INT default 0;


    DECLARE cur_naslov_id INT;


    DECLARE naslov_cur CURSOR FOR SELECT naslovId FROM naslov ORDER BY rand() limit rc_n;

    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'
        SET d = 1;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '23000'
        SET d = 1;
    OPEN naslov_cur;
    FETCH naslov_cur INTO cur_naslov_id;
    loop_lbl:
    LOOP
        IF d = 1 THEN
            LEAVE loop_lbl;
        END IF;
        IF NOT d = 1 THEN
            INSERT INTO student(vpisna_stevilka, ime, priimek, predizobrazba, Smer_id, Naslov_id)
            VALUES ((SELECT LEFT(UUID(), 8)), concat('Ime ', studentIndex),
                    concat('Priimek ', studentIndex),
                    'Predizobrazba', FLOOR(RAND() * ((SELECT COUNT(smerId) FROM smer) - 1) + 1), cur_naslov_id);
            SET studentIndex = studentIndex + 1;
            FETCH naslov_cur INTO cur_naslov_id;
        END IF;
    END LOOP;
    CLOSE naslov_cur;

END
//

DELIMITER //

CREATE PROCEDURE NAPOLNI_VAJE(in rc int)
BEGIN

    DECLARE d INT default 0;

    DECLARE predmet_naziv VARCHAR(45);
    DECLARE predmet_id INT;

    DECLARE predmet_cur CURSOR FOR SELECT predmetId, naziv FROM predmet ORDER BY rand() LIMIT rc;

    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'
        SET d = 1;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '23000'
        SET d = 1;

    OPEN predmet_cur;
    FETCH predmet_cur INTO predmet_id, predmet_naziv;
    loop_lbl:
    LOOP
        IF d = 1 THEN
            LEAVE loop_lbl;
        END IF;
        IF NOT d = 1 THEN
            INSERT INTO vaje(vsebina, Predmet_id) VALUES (concat('Vsebina vaj za predmet ', predmet_naziv), Predmet_id);
            FETCH predmet_cur INTO predmet_id, predmet_naziv;
        END IF;

    END LOOP;
    close predmet_cur;

END //


DELIMITER //

CREATE PROCEDURE NAPOLNI_STUDENT_PREDMET(in rc_p int)

BEGIN
    DECLARE d INT default 0;

    DECLARE cur_predmet_id INT;

    DECLARE predmet_cur CURSOR FOR SELECT predmetId FROM predmet ORDER BY rand() LIMIT rc_p;

    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'
        SET d = 1;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '23000'
        SET d = 1;
    OPEN predmet_cur;
    FETCH predmet_cur INTO cur_predmet_id;

    loop_lbl:
    LOOP
        IF d = 1 THEN
            LEAVE loop_lbl;
        END IF;
        IF NOT d = 1 THEN
            INSERT INTO student_obiskuje_predmet(student_id, predmet_id, datum)
            VALUES (ROUND(RAND() * ((SELECT COUNT(predmetId) FROM predmet) - 1) + 1), cur_predmet_id,
                    (SELECT CURRENT_TIMESTAMP - INTERVAL FLOOR(RAND() * 14 * 24 * 60 * 60) SECOND));
            FETCH predmet_cur INTO cur_predmet_id;


        END IF;
    END LOOP;
    CLOSE predmet_cur;
END
//

DELIMITER //

CREATE PROCEDURE NAPOLNI_PREDMET_DELAVEC(in rc_p int)
BEGIN
    DECLARE d INT default 0;

    DECLARE cur_predmet_id INT;
    DECLARE cur_delavec_id INT;

    DECLARE predmet_cur CURSOR FOR SELECT predmetId FROM predmet ORDER BY rand() LIMIT rc_p;

    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'
        SET d = 1;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '23000'
        SET d = 1;
    OPEN predmet_cur;
    FETCH predmet_cur INTO cur_predmet_id;

    loop_lbl:
    LOOP
        IF d = 1 THEN
            LEAVE loop_lbl;
        END IF;
        IF NOT d = 1 THEN
            INSERT INTO predmet_uci_delavec(Predmet_id, Delavec_id, vloga)
            VALUES (cur_predmet_id, ROUND(RAND() * ((SELECT COUNT(delavecId) FROM delavec) - 1) + 1),
                    ELT(0.5 + RAND() * 3, 'PROFESOR', 'ASISTENT', 'LABORANT'));
            FETCH predmet_cur INTO cur_predmet_id;


        END IF;
    END LOOP;
    CLOSE predmet_cur;
END
//


DELIMITER //

CREATE PROCEDURE NAPOLNI_PRISOTNOST(in rc_v int)
BEGIN
    DECLARE d INT default 0;
    DECLARE student_id INT;
    DECLARE vaje_id INT;

    DECLARE vaje_cur CURSOR FOR SELECT vajeId FROM vaje ORDER BY rand() LIMIT rc_v;

    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'
        SET d = 1;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '23000'
        SET d = 1;
    OPEN vaje_cur;
    FETCH vaje_cur INTO vaje_id;

    loop_lbl:
    LOOP
        if d = 1 THEN
            LEAVE loop_lbl;
        END IF;
        IF NOT d = 1 THEN

            INSERT INTO prisotnost(student_id, datum, prisoten, vaje_id, opravicilo)
            VALUES (ROUND(RAND() * ((SELECT COUNT(studentId) FROM student) - 1) + 1),
                    (SELECT CURRENT_TIMESTAMP - INTERVAL FLOOR(RAND() * 14 * 24 * 60 * 60) SECOND),
                    (select floor(rand() * 10) % 2), vaje_id, '');
            FETCH vaje_cur INTO vaje_id;

        END IF;
    END LOOP;
    CLOSE vaje_cur;
END //

DELIMITER //

CREATE PROCEDURE NAPOLNI_OCENE(in rc_v int)
BEGIN
    DECLARE d INT default 0;
    DECLARE student_id INT;
    DECLARE vaje_id INT;

    DECLARE vaje_cur CURSOR FOR SELECT vajeId FROM vaje ORDER BY rand() LIMIT rc_v;

    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'
        SET d = 1;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '23000'
        SET d = 1;
    OPEN vaje_cur;
    FETCH vaje_cur INTO vaje_id;

    loop_lbl:
    LOOP
        if d = 1 THEN
            LEAVE loop_lbl;
        END IF;
        IF NOT d = 1 THEN
            INSERT INTO ocena_vaj(Student_id, ocena, datum, Vaje_id)
            VALUES (ROUND(RAND() * ((SELECT COUNT(studentId) FROM student) - 1) + 1),
                    (select floor(rand() * 10) % 10 + 1),
                    (SELECT CURRENT_TIMESTAMP - INTERVAL FLOOR(RAND() * 14 * 24 * 60 * 60) SECOND),
                    vaje_id);
            FETCH vaje_cur INTO vaje_id;
        END IF;
    END LOOP;
    CLOSE vaje_cur;
END
//

# call NAPOLNI_DRZAVO(1000);
# call NAPOLNI_SMER(1000);
# CALL NAPOLNI_KRAJ(1000);
# call NAPOLNI_NASLOV(1000);
# call NAPOLNI_DELAVEC(1000);
# call NAPOLNI_PREDMET(1000);
# call NAPOLNI_STUDENT(1000);
# call NAPOLNI_VAJE(1000);
# call NAPOLNI_STUDENT_PREDMET(1000);
# call NAPOLNI_PREDMET_DELAVEC(1000);
# call NAPOLNI_PRISOTNOST(1000);
# call NAPOLNI_OCENE(1000);