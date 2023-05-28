/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada letra minúscula en la columna 2.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
u = LOAD 'data.tsv' USING PigStorage('\t')
        AS(COL1:CHARARRAY, 
        COL2:BAG{t:TUPLE(chararray)},
        COL3:MAP[]);

y = FOREACH u GENERATE FLATTEN(COL2) as letters;
z = GROUP y BY letters;
x = FOREACH z GENERATE group, COUNT(y);
STORE x INTO 'output'USING PigStorage(',');
