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
        COL2:BAG{t:TUPLE(letra:CHARARRAY)},
        COL3:MAP[]);

v = FOREACH u GENERATE COL2;
x = FOREACH v GENERATE FLATTEN(COL2) as palabra;
y = GROUP x by palabra;
z = FOREACH y GENERATE group, count(x);
STORE z into 'output' USING PigStorage(',');
