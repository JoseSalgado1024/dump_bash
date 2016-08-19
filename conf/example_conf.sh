#!/bin/bash

############
## ORIGIN ##
############

HOST_DB="sepa-prod-historico-db.c2setm4u4yff.us-east-1.rds.amazonaws.com";
NAME_DB="sepa_db";
PORT_DB="5432";

# USER DATA
USER_DB="gobiernoabierto";
PASS_DB="gobabierto";

# TABLES TO DUMP
TABLES=("table_01" "table_02" "table_03" "table_04");
DUMP_FILENAME="dump"

#################
## DESTINATION ##
#################

BUCKET_NAME="secom-sepa/dumps/sepa_db_historica";

# Completar con true o false
COMPRESS_DUMP=true;
