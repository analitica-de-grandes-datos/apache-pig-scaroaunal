/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
u = LOAD 'data.tsv' AS 
        ( letras:charArray,
          letrasBag:bag{},
          lista:map[]);

v = FOREACH u GENERATE letrasBag, FLATTEN(lista) as listasep; 
x = FOREACH v GENERATE letrasBag, FLATTEN(listasep) as listasep2;
y = FOREACH  x GENERATE listasep2, FLATTEN(letrasBag) as letra_1;
z = GROUP y BY (letra_1,listasep2);
zz = FOREACH  Z GENERATE group as col1, count(z) as col2;
zz = ORDER zz BY col1,col2;
STORE zz INTO 'output' USING PigStorage(',');

