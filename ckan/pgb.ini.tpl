[databases]
${HDX_CKANDB_DB} = host=dbckan port=5432 pool_size=240 dbname=${HDX_CKANDB_DB}
${HDX_CKANDB_DB_DATASTORE} = host=dbckan port=5432 pool_size=120 dbname=${HDX_CKANDB_DB_DATASTORE}
${HDX_GISDB_DB} = host=gisdb port=5432 pool_size=180 dbname=${HDX_GISDB_DB}

[pgbouncer]
pool_mode = session
listen_port = 5432
listen_addr = 127.0.0.1
auth_type = md5
auth_file = /srv/pgb/pgb.users
logfile = /srv/pgb/pgb.log
pidfile = /srv/pgb/pgb.pid
admin_users = pgb
max_client_conn = 3000
log_connections = 0
log_disconnections = 0
log_pooler_errors = 1
