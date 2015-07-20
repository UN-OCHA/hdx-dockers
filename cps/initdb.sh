#/bin/bash

pg_restore -vOx -h ${HDX_CPSDB_ADDR} -p ${HDX_CPSDB_PORT} -U ${HDX_CPSDB_USER} -d ${HDX_CPSDB_DB} /srv/cps_schema_0_5_16.plsql

psql -h ${HDX_CPSDB_ADDR} -p ${HDX_CPSDB_PORT} -U ${HDX_CPSDB_USER} ${HDX_CPSDB_DB} -f /srv/cps-initial-user.sql
