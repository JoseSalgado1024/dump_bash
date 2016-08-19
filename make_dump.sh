#!/bin/bash

# DUMPS SEMANALES

clear

echo "##############################################"
echo "##                                          ##"
echo "##             dumps semanales              ##"
echo "##       $(date)       ##"
echo "##                                          ##"
echo "##############################################"
echo ""
WORK_FOLDER="conf";
config_file="$WORK_FOLDER/dumps.cfg";

if [ "$#" -gt "0"] 
  then
  config_file=$1; 
fi

if [ -f "$config_file" ]
then
    echo " >> Cargando config_file: \"$config_file\"...";
    source $config_file;
    ACTUAL_DATE=$(date +"_%d-%m-%Y.sql")
    FNAME="$DUMP_FILENAME$ACTUAL_DATE"
    echo " >> Archivo cargado correctamente!";
    cmd="export PGUSER=$USER_DB; export PGPASSWORD=$PASS_DB;";
    echo " >> Seteando variables de sistema \"PGUSER\" y \"PGPASSWORD\"..."
    eval $cmd;
    exit_code=$?
    if [ "$exit_code" -gt "0" ]
    then
       exit $exit_code;
    else
       echo "	...Hecho!"
    fi 
    cmd="pg_dump -a -v -f $FNAME -h $HOST_DB";
    echo " >> Preparando tablas que se van a incluir en el dump..."
    for table in ${TABLES[@]}
        do
	  cmd="$cmd -t $table ";
	done
    cmd="$cmd $NAME_DB";
    echo " >> Ejecutando: \"$cmd\...";
    echo " >> PG_DUMP Dice:"
    eval $cmd

    exit_code=$?
    if [ "$exit_code" -eq "0" ]
    then
       echo " >> Dump finalizado con exito!"
       if $COMPRESS_DUMP ;
       then
	echo " >> Creando ZIP file..."
	eval "zip -r $FNAME.zip $FNAME"
	exit_code=$?
	if [ "$exit_code" -gt "0" ]
	   then
	       exit $exit_code
           else
               echo "	...Hecho!"
	fi
        FNAME=$FNAME".zip"
       fi
       echo "aws s3 cp $FNAME s3://$BUCKET_NAME"
    else
       echo " >> ...Fallo Dump para: \"$NAME_DB\" en \"$HOST_DB\""
    fi
    echo "" 
    exit $exit_code;
else
    echo " >> Imposible cargar configuracion de [$config_file], archivo no encontrado..."
    exit 1;
fi
