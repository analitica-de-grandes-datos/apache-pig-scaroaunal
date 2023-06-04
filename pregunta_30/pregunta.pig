/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el codigo en Pig para manipulación de fechas que genere la siguiente
salida.

   1971-07-08,08,8,jue,jueves
   1974-05-23,23,23,jue,jueves
   1973-04-22,22,22,dom,domingo
   1975-01-29,29,29,mie,miercoles
   1974-07-03,03,3,mie,miercoles
   1974-10-18,18,18,vie,viernes
   1970-10-05,05,5,lun,lunes
   1969-02-24,24,24,lun,lunes
   1974-10-17,17,17,jue,jueves
   1975-02-28,28,28,vie,viernes
   1969-12-07,07,7,dom,domingo
   1973-12-24,24,24,lun,lunes
   1970-08-27,27,27,jue,jueves
   1972-12-12,12,12,mar,martes
   1970-07-01,01,1,mie,miercoles
   1974-02-11,11,11,lun,lunes
   1973-04-01,01,1,dom,domingo
   1973-04-29,29,29,dom,domingo

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

u = LOAD 'data.csv' USING PigStorage(',')
        AS(col1:INT,
           col2:charArray,
           col3:charArray,
           col4:charArray,
           col5:charArray,
           col6:INT);

u = FOREACH u GENERATE col4, LOWER(ToString(ToDate(col4, 'yyyy-MM-dd'), 'EEE')) AS day_short, LOWER(ToString(ToDate(col4, 'yyyy-MM-dd'), 'EEEE')) AS day_long;

data_day = FOREACH u GENERATE col4,ToString(ToDate(col4, 'yyyy-MM-dd'), 'dd'),ToString(ToDate(col4, 'yyyy-MM-dd'), 'd'),
                                 (CASE day_short
                                        WHEN 'mon' THEN 'lun'
                                        WHEN 'tue' THEN 'mar'
                                        WHEN 'wed' THEN 'mie'
                                        WHEN 'thu' THEN 'jue'
                                        WHEN 'fri' THEN 'vie'
                                        WHEN 'sat' THEN 'sab'
                                        WHEN 'sun' THEN 'dom'
                                        ELSE day_short
                                END),
                                 (CASE day_long
                                        WHEN 'monday' THEN 'lunes'
                                        WHEN 'tuesday' THEN 'martes'
                                        WHEN 'wednesday' THEN 'miercoles'
                                        WHEN 'thursday' THEN 'jueves'
                                        WHEN 'friday' THEN 'viernes'
                                        WHEN 'saturday' THEN 'sabado'
                                        WHEN 'sunday' THEN 'domingo'
                                        ELSE day_long
                                END);

STORE data_day INTO 'output' USING PigStorage(',');