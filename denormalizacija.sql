USE mydb;
#
# #Z omejitev
# #100k
# SET foreign_key_checks = 0;
# TRUNCATE TABLE drzava;
# TRUNCATE TABLE kraj;
# TRUNCATE TABLE naslov;
# TRUNCATE TABLE smer;
# TRUNCATE TABLE student;
# SET foreign_key_checks = 1;
#
# call NAPOLNI_DRZAVO(100000);
# call NAPOLNI_KRAJ(100000);
# CALL NAPOLNI_NASLOV(100000);
# CALL NAPOLNI_SMER(100000);
# CALL NAPOLNI_STUDENT(100000);
#
# SELECT *
# FROM student
# WHERE studentId = 2002
#    OR ime = '15';
#
# SELECT *
# FROM student
# WHERE studentId = 119;
#
# SELECT *
# FROM smer
# WHERE smerId = 2002;
#
# SELECT *
# FROM smer
# WHERE smerId = 2002
#     AND naziv = 'smer-2002'
#    OR naziv = 'smer-2001';
#
# UPDATE smer
# set naziv = 'smer-sprememba',
#     opis='opis smera sprememba'
# WHERE smerId = 1996;
#
# UPDATE smer
# set naziv = 'smer-sprememba-vseh',
#     opis  = 'opis vseh smerov sprememba';
#
# UPDATE student
# set ime     = 'Student sprememba',
#     priimek = 'Student sprememba'
# WHERE studentId = 2002;
#
# UPDATE student
# set ime     = 'Student sprememba',
#     priimek = 'Student sprememba';
#
# DELETE
# FROM student
# WHERE Smer_id = 203;
#
# DELETE
# FROM smer
# where smerId = 203;
#
# DELETE
# FROM student;
#
# DELETE
# FROM smer;
#
#
# # 1mil
#
# SET foreign_key_checks = 0;
# TRUNCATE TABLE drzava;
# TRUNCATE TABLE kraj;
# TRUNCATE TABLE naslov;
# TRUNCATE TABLE smer;
# TRUNCATE TABLE student;
# SET foreign_key_checks = 1;
#
# call NAPOLNI_DRZAVO(1000000);
# call NAPOLNI_KRAJ(1000000);
# CALL NAPOLNI_NASLOV(1000000);
# CALL NAPOLNI_SMER(1000000);
# CALL NAPOLNI_STUDENT(1000000);
#
# SELECT *
# FROM student
# WHERE studentId = 2002
#    OR ime = '15';
#
# SELECT *
# FROM student
# WHERE studentId = 119;
#
# SELECT *
# FROM smer
# WHERE smerId = 2002;
#
# SELECT *
# FROM smer
# WHERE smerId = 2002
#     AND naziv = 'smer-2002'
#    OR naziv = 'smer-2001';
#
# UPDATE smer
# set naziv = 'smer-sprememba',
#     opis='opis smera sprememba'
# WHERE smerId = 1996;
#
# UPDATE smer
# set naziv = 'smer-sprememba-vseh',
#     opis  = 'opis vseh smerov sprememba';
#
# UPDATE student
# set ime     = 'Student sprememba',
#     priimek = 'Student sprememba'
# WHERE studentId = 2002;
#
# UPDATE student
# set ime     = 'Student sprememba',
#     priimek = 'Student sprememba';
#
# DELETE
# FROM student
# WHERE Smer_id = 203;
#
# DELETE
# FROM smer
# where smerId = 203;
#
# DELETE
# FROM student;
#
# DELETE
# FROM smer;


alter table student
    drop foreign key fk_Student_Naslov1;
alter table student
    drop foreign key fk_Student_Smer1;
drop index fk_Student_Naslov1_idx on student;
drop index fk_Student_Smer1_idx on student;

#Brez omejitev
#100k
SET foreign_key_checks = 0;
TRUNCATE TABLE drzava;
TRUNCATE TABLE kraj;
TRUNCATE TABLE naslov;
TRUNCATE TABLE smer;
TRUNCATE TABLE student;
SET foreign_key_checks = 1;

call NAPOLNI_DRZAVO(100000);
call NAPOLNI_KRAJ(100000);
CALL NAPOLNI_NASLOV(100000);
CALL NAPOLNI_SMER(100000);
CALL NAPOLNI_STUDENT(100000);

SELECT *
FROM student
WHERE studentId = 2002
   OR ime = '15';

SELECT *
FROM student
WHERE studentId = 119;

SELECT *
FROM smer
WHERE smerId = 2002;

SELECT *
FROM smer
WHERE smerId = 2002
    AND naziv = 'smer-2002'
   OR naziv = 'smer-2001';

UPDATE smer
set naziv = 'smer-sprememba',
    opis='opis smera sprememba'
WHERE smerId = 1996;

UPDATE smer
set naziv = 'smer-sprememba-vseh',
    opis  = 'opis vseh smerov sprememba';

UPDATE student
set ime     = 'Student sprememba',
    priimek = 'Student sprememba'
WHERE studentId = 2002;

UPDATE student
set ime     = 'Student sprememba',
    priimek = 'Student sprememba';

DELETE
FROM student
WHERE Smer_id = 203;

DELETE
FROM smer
where smerId = 203;

DELETE
FROM student;

DELETE
FROM smer;


# 1mil

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

SELECT *
FROM student
WHERE studentId = 2002
   OR ime = '15';

SELECT *
FROM student
WHERE studentId = 119;

SELECT *
FROM smer
WHERE smerId = 2002;

SELECT *
FROM smer
WHERE smerId = 2002
    AND naziv = 'smer-2002'
   OR naziv = 'smer-2001';

UPDATE smer
set naziv = 'smer-sprememba',
    opis='opis smera sprememba'
WHERE smerId = 1996;

UPDATE smer
set naziv = 'smer-sprememba-vseh',
    opis  = 'opis vseh smerov sprememba';

UPDATE student
set ime     = 'Student sprememba',
    priimek = 'Student sprememba'
WHERE studentId = 2002;

UPDATE student
set ime     = 'Student sprememba',
    priimek = 'Student sprememba';

DELETE
FROM student
WHERE Smer_id = 203;

DELETE
FROM smer
where smerId = 203;

DELETE
FROM student;

DELETE
FROM smer;
