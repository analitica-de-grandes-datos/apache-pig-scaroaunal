/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código en Pig para manipulación de fechas que genere la siguiente 
salida.

   1971-07-08,jul,07,7
   1974-05-23,may,05,5
   1973-04-22,abr,04,4
   1975-01-29,ene,01,1
   1974-07-03,jul,07,7
   1974-10-18,oct,10,10
   1970-10-05,oct,10,10
   1969-02-24,feb,02,2
   1974-10-17,oct,10,10
   1975-02-28,feb,02,2
   1969-12-07,dic,12,12
   1973-12-24,dic,12,12
   1970-08-27,ago,08,8
   1972-12-12,dic,12,12
   1970-07-01,jul,07,7
   1974-02-11,feb,02,2
   1973-04-01,abr,04,4
   1973-04-29,abr,04,4

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


data_month = FOREACH data u col4, LOWER(ToString(ToDate(col4, 'yyyy-MM-dd'), 'MMM')) AS month;

data_month = FOREACH data_month GENERATE col4,
                     (CASE month
                        WHEN 'jan' THEN 'ene'
                        WHEN 'feb' THEN 'feb'
                        WHEN 'mar' THEN 'mar'
                        WHEN 'apr' THEN 'abr'
                        WHEN 'may' THEN 'may'
                        WHEN 'jun' THEN 'jun'
                        WHEN 'jul' THEN 'jul'
                        WHEN 'aug' THEN 'ago'
                        WHEN 'sep' THEN 'sep'
                        WHEN 'oct' THEN 'oct'
                        WHEN 'nov' THEN 'nov'
                        WHEN 'dec' THEN 'dic'
                        ELSE month
                     END),
                     ToString(ToDate(col4, 'yyyy-MM-dd'), 'MM'),
                     ToString(ToDate(col4, 'yyyy-MM-dd'), 'M');

STORE data_month INTO 'output' USING PigStorage(',');