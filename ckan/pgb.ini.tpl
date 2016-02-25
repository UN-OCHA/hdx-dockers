[databases]
${HDX_CKANDB_DB} = host=${HDX_CKANDB_ADDR} port=${HDX_CKANDB_PORT} dbname=${HDX_CKANDB_DB}
${HDX_CKANDB_DB_DATASTORE} = host=${HDX_CKANDB_ADDR} port=${HDX_CKANDB_PORT} dbname=${HDX_CKANDB_DB_DATASTORE}
${HDX_GISDB_DB} = host=${HDX_GISDB_ADDR} port=${HDX_GISDB_PORT} dbname=${HDX_GISDB_DB}

[pgbouncer]
pool_mode = session
listen_port = 5432
listen_addr = 127.0.0.1
auth_type = md5
auth_file = /srv/pgb/pgb.users
logfile = /srv/pgb/pgb.log
pidfile = /srv/pgb/pgb.pid
#admin_users = someuser
