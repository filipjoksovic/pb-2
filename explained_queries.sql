USE mydb;
EXPLAIN SELECT 
    *
FROM
    student
WHERE
    priimek = '2010' OR ime = '15';


EXPLAIN SELECT 
    *
FROM
    student
WHERE
    ime = '15';
    

EXPLAIN SELECT 
    *
FROM
    smer
WHERE
    smer.naziv = 'smer-105';
    

EXPLAIN SELECT 
    *
FROM
    smer
WHERE
    naziv = 'smer-2002'
        OR naziv = 'smer-2001';
        

EXPLAIN UPDATE smer 
SET 
    naziv = 'smer-sprememba',
    opis = 'opis smera sprememba'
WHERE
    smer.naziv = 'smer-2002';
    

EXPLAIN UPDATE smer 
SET 
    naziv = 'smer-sprememba-vseh',
    opis = 'opis vseh smerov sprememba';
    

EXPLAIN UPDATE student 
SET 
    ime = 'Student sprememba',
    priimek = 'Student sprememba'
WHERE
    student.ime = '2010';
    

EXPLAIN UPDATE student 
SET 
    ime = 'Student sprememba',
    priimek = 'Student sprememba';
    

EXPLAIN DELETE FROM student 
WHERE
    student.ime = '2013';
    

EXPLAIN DELETE FROM smer 
WHERE
    naziv = 'smer-203';
    

EXPLAIN DELETE FROM student;


EXPLAIN DELETE FROM smer;

SET SQL_SAFE_UPDATES = 1;
