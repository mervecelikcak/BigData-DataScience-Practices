-- Indica el nombre menos repetido

people = LOAD '/people-2000000.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',', 'YES_MULTILINE', 'NOCHANGE', 'SKIP_INPUT_HEADER') AS (indice:int, id:chararray, nombre:chararray, apellidos:chararray, sexo:chararray, correo:chararray, telefono:chararray, fecha_de_nacimiento:datetime, cargo:chararray);

-- Count Nombres
nombre = GROUP people BY nombre;
nombre_count = FOREACH nombre GENERATE group AS nombre, COUNT(people) AS count;

-- DUMP nombre_count;

-- Sort Nombres
sorted_data = ORDER nombre_count BY count ASC;
min_nombre = LIMIT sorted_data 1;
DUMP min_nombre;
