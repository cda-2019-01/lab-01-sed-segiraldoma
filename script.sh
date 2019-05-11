 # Escriba su código aquí
sed 's%/%-%g' data.csv > out.1 #Cambia / por -
sed 's/;\([0-9]\);\([0-9][0-9][0-9]\);\([0-9]\)/\;1;\2,\3/' out.1 > out.2 # Cambia la separacion decimal de ; a ,
sed 's/,/./g' out.2 > out.3 # Cambia , por .
sed 's/;/,/g' out.3 > out.4 # Cambia ; por ,
sed 's/\([0-9][0-9]\)-\([0-9][0-9]\)-\([0-9][0-9]\),/20\3-\2-\1,/' out.4 > out.5  #Cambia de orden las fechas de DD/MM/YY a YYYY/MM/DD, como no se conoce la data el año lo ponemos del 2000
sed 's/,,/,\\N,/g' out.5 > out.6 # Se llenan los campos vacios por \N, menos los vacios que estan al final
sed -e 's/.$/,/' out.6 > out.7 # Se agrega una , al final de la ultima linea para determinar donde quedan datos vacios al final
sed 's/,,/,\\N,/g' out.7 > out.8 # Se agrega \N a los campos vacios del final
sed -e 's/.$//' out.8 > out.9 # Se borra la , agragada al final
cat out.9 | tr [:lower:] [:upper:] > out.10 # Cambia minusculas por mayusculas
sed 's/,N/\,\\N/g' out.10 > out.11 # Remplaza N por \N
grep -v \N out.11  #Se filtran las lines no tienen campos nulos
rm out.* # Se borran todos los temporales del proyecto
