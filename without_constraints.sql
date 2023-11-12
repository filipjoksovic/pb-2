USE mydb;

alter table student
    drop foreign key fk_Student_Naslov1;
alter table student
    drop foreign key fk_Student_Smer1;
drop index fk_Student_Naslov1_idx on student;
drop index fk_Student_Smer1_idx on student;


SET SQL_SAFE_UPDATES = 0;
SET foreign_key_checks = 0;
TRUNCATE TABLE drzava;
TRUNCATE TABLE kraj;
TRUNCATE TABLE naslov;
TRUNCATE TABLE smer;
TRUNCATE TABLE student;
SET foreign_key_checks = 1;

call NAPOLNI_DRZAVO(1000000);
call NAPOLNI_KRAJ(1000000);
CALL NAPOLNI_NASLOV(1000000);
CALL NAPOLNI_SMER(1000000);
CALL NAPOLNI_STUDENT(1000000);

SELECT 
    *
FROM
    student
WHERE
    priimek = '2010' OR ime = '15';


SELECT 
    *
FROM
    student
WHERE
    ime = '15';
    

SELECT 
    *
FROM
    smer
WHERE
    smer.naziv = 'smer-105';
    

SELECT 
    *
FROM
    smer
WHERE
    naziv = 'smer-2002'
        OR opis = 'smer-2001';
        

UPDATE smer 
SET 
    naziv = 'smer-sprememba',
    opis = 'opis smera sprememba'
WHERE
    smer.naziv = 'smer-2002';
    

UPDATE smer 
SET
    naziv = 'smer-sprememba-vseh',
    opis = 'opis vseh smerov sprememba';
    

UPDATE student 
SET 
    ime = 'Student sprememba',
    priimek = 'Student sprememba'
WHERE
    student.ime = '2010';
    

UPDATE student 
SET 
    ime = 'Student sprememba',
    priimek = 'Student sprememba';
    

DELETE FROM student 
WHERE
    student.ime = '2013';
    

DELETE FROM smer 
WHERE
    naziv = 'smer-203';
    

DELETE FROM student;


DELETE FROM smer;

SET SQL_SAFE_UPDATES = 1;
