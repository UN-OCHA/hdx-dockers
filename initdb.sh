#/bin/bash

pg_restore -vOx -h db -U cps -d cps /srv/cps_schema_0_5_16.plsql

psql -h db -U cps cps -f /srv/cps-initial-user.sql
