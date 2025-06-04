people = LOAD '/people-2000000.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',', 'YES_MULTILINE', 'NOCHANGE', 'SKIP_INPUT_HEADER') AS (indice:int, id:chararray, nombre:chararray, apellidos:chararray, sexo:chararray, correo:chararray, telefono:chararray, fecha_de_nacimiento:datetime, cargo:chararray);

-- Count Each Gender
gender_el = GROUP people BY sexo;
gender_count = FOREACH gender_el GENERATE group AS sexo, COUNT(people) AS count;

-- DUMP gender_count;

-- Count Men & Women
sorted_data = ORDER gender_count BY count DESC;
max_gender = LIMIT sorted_data 1;
DUMP max_gender;

