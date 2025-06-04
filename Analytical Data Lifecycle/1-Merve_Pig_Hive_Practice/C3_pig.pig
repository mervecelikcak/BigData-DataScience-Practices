people = LOAD '/home/ubuntu/Descargas/people-2000000.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',', 'YES_MULTILINE', 'NOCHANGE', 'SKIP_INPUT_HEADER') AS (indice:int, id:chararray, nombre:chararray, apellidos:chararray, sexo:chararray, correo:chararray, telefono:chararray, fecha_de_nacimiento:datetime, cargo:chararray);

-- Count Each Job
job = GROUP people BY cargo;
job_count = FOREACH job GENERATE group AS cargo, COUNT(people) AS count;

-- DUMP job_count;

-- Sort Job
sorted_data = ORDER job_count BY count DESC;

DUMP sorted_data;

