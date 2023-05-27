/* 
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra.
Almacene los resultados separados por comas. 

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

u = LOAD 'data.tsv' USING PigStorage('\t')
        AS(letra:CHARARRAY,
        fecha:CHARARRAY,
        numero:INT);
y = GROUP u BY $0;
z = FOREACH y GENERATE $0, COUNT($1);
store z into 'output';
