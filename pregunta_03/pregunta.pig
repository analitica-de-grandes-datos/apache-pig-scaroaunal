/*
Pregunta
===========================================================================

Obtenga los cinco (5) valores más pequeños de la 3ra columna.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

u = LOAD 'data.tsv' USING PigStorage('\t')
        AS(letra:CHARARRAY,
        fecha:CHARARRAY,
        numero:INT);

y = ORDER u BY  numero;
y = LIMIT y 5;
z = FOREACH y GENERATE numero;
store z into 'output' USING PigStorage(',');
