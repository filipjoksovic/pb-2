ALTER TABLE smer ADD INDEX `bt_naziv_index` (naziv) USING BTREE;
ALTER TABLE student ADD INDEX `bt_ime_index` (ime) USING BTREE;

-- ALTER TABLE smer ADD INDEX `bt_naziv_opis_index` (naziv,opis(50)) USING BTREE;
-- ALTER TABLE student ADD INDEX `bt_ime_priimek_index`(ime,priimek) USING BTREE;

-- ALTER TABLE smer drop index `bt_naziv_opis_index`;
-- ALTER table student drop index `bt_ime_priimek_index`;


ALTER TABLE smer drop index `bt_naziv_index`;
ALTER table student drop index `bt_ime_index`;


