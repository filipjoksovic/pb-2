USE mydb;
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
        OR naziv = 'smer-2001';
        

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
