#/bin/bash

# create cps schema and a default user if we have an empty database
if [ "$(psql -h dbcps -p 5432 -U cps cps -c '\d')" == "No relations found." ]; then
    echo "Create empty cps schema"
    pg_restore -vOx -h dbcps -p 5432 -U ${HDX_CPSDB_USER} -d ${HDX_CPSDB_DB} /srv/cps_schema_0_5_16.plsql
    echo "Create example admin user"
    psql -h dbcps -p 5432 -U ${HDX_CPSDB_USER} ${HDX_CPSDB_DB} -f /srv/cps-initial-user.sql
fi
