/*
Pregunta
===========================================================================

Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
columna 3. En otras palabras, cuántos registros hay que tengan la clave 
`aaa`?

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
u = LOAD 'data.tsv' AS 
        ( letter:charArray,
          letter_bag:bag{},
          lista:map[]);
          
v = FOREACH u GENERATE FLATTEN(lista) as letras;
z = FOREACH (GROUP v BY letras) GENERATE group,COUNT(v.letras);
STORE z INTO 'output' USING PigStorage(',');
