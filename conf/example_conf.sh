#!/bin/bash

############
## ORIGIN ##
############

HOST_DB="some_host";
NAME_DB="some_db_name";
PORT_DB="db_port";

# USER DATA
USER_DB="your_user";
PASS_DB="password_user";

# TABLES TO DUMP
TABLES=("table_01" "table_02" "table_03" "table_04");
DUMP_FILENAME="dump"

#################
## DESTINATION ##
#################

BUCKET_NAME="some_aws_bucket";

# Comprimir? Completar con true o false
COMPRESS_DUMP=true;
