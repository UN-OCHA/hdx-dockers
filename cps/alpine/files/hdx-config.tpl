ckan.host = ${HDX_PREFIX}data.${HDX_DOMAIN}
ckan.host.ishttps = true
ckan.technical.api.key = ${HDX_CKAN_API_KEY}

db.url=jdbc:postgresql://dbcps:5432/${HDX_CPSDB_DB}
db.username=${HDX_CPSDB_USER}
db.password=${HDX_CPSDB_PASS}

smtp.host=email
smtp.port=25
mail.from=cps.${HDX_TYPE}@${HDX_DOMAIN}
