people = LOAD '/people-2000000.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',', 'YES_MULTILINE', 'NOCHANGE', 'SKIP_INPUT_HEADER') AS (indice:int, id:chararray, nombre:chararray, apellidos:chararray, sexo:chararray, correo:chararray, telefono:chararray, fecha_de_nacimiento:datetime, cargo:chararray);

-- DUMP people;

oldest_person = ORDER people BY fecha_de_nacimiento ASC;
oldest_person = LIMIT oldest_person 1;
DUMP oldest_person;
