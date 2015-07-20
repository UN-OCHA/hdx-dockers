#/bin/bash

pg_restore -vOx -h ${HDX_CPSDB_ADDR} -p ${HDX_CPSDB_PORT} -U cps -d cps /srv/cps_schema_0_5_16.plsql

psql -h ${HDX_CPSDB_ADDR} -p ${HDX_CPSDB_PORT} -U cps cps -f /srv/cps-initial-user.sql
