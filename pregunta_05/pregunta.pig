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
u = LOAD 'data.tsv'
        AS(COL1:CHARARRAY, 
        COL2:BAG{},
        COL3:MAP[]);

v = FOREACH u GENERATE COL2;
x = FOREACH v GENERATE FLATTEN(COL2) AS palabra;
y = GROUP x BY palabra;
z = FOREACH y GENERATE group, COUNT(x);

STORE z INTO 'output' USING PigStorage(',');