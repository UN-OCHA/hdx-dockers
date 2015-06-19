#!/bin/bash

# this backup script assumes you are using hdx postgres docker image
#   linked as "db"

PREFIX="XXX"
SUFFIX=$(date +%Y%m%d-%H%M%S)
BACKUPDIR="/srv/backup"

if [[ -z $DB_PORT_5432_TCP_ADDR ] || [ -z $$DB_ENV_POSTGRESQL_USER ] || [ -z $DB_ENV_POSTGRESQL_DB ] || [ -z $DB_ENV_POSTGRESQL_DATASTORE_DB ] || [ -z $DB_ENV_POSTGRESQL_PASS ]]; then
    echo "Missing env variables. Exiting.";
    exit 1;
fi

if [ $PREFIX == "XXX" ]; then
    echo "To run the backup, please change the prefix into prod, staging, dev, whatever.";
    exit 1
fi

export PGPASSWORD=$DB_ENV_POSTGRESQL_PASS
mkdir -p $BACKUPDIR

function dump_db () {
    BACKUPFILE=$PREFIX.ckan.db.$1.$SUFFIX.plsql
    pg_dump -vFt -h $DB_PORT_5432_TCP_ADDR -U $DB_ENV_POSTGRESQL_USER -f $BACKUPDIR/$BACKUPFILE $1 > /dev/null 2>&1
    gzip $BACKUPDIR/$BACKUPFILE
}

dump_db $DB_ENV_POSTGRESQL_DB;
dump_db $DB_ENV_POSTGRESQL_DATASTORE_DB;

