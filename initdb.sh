#!/bin/bash

POSTGRESQL_DATA=/srv/db

if [ ! -d $POSTGRESQL_DATA ]; then
    #mkdir -p $POSTGRESQL_DATA
    chown -R postgres:postgres $POSTGRESQL_DATA
    sudo -u postgres /usr/lib/postgresql/9.3/bin/initdb -D $POSTGRESQL_DATA -E utf-8
else
    echo "$POSTGRESL_DATA dir is not empty!"
fi

echo "Trying to create the skeleton of cps"
psql -U cps cps -f /srv/cps-0.5.1.sql

