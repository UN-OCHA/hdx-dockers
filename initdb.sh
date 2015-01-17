#/bin/bash

pg_restore -vOx -U cps -d cps /srv/cps_schema_0_5_16.plsql

psql -U cps cps -f /srv/cps-initial-user.sql
