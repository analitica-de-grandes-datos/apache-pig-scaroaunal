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
data = LOAD 'data.tsv' AS 
        ( letter:charArray,
          letter_bag:bag{},
          lista:map[]);

data = FOREACH data GENERATE FLATTEN(letter_bag) AS letra, FLATTEN(lista) AS lista_letras;
grupo = GROUP data by (letra,lista_letras);
result = FOREACH grupo GENERATE group, COUNT(data);
STORE result INTO 'output' USING PigStorage(',');

