ckan.host = ${HDX_PREFIX}data.${HDX_DOMAIN}
ckan.technical.api.key = ${HDX_CKAN_API_KEY}

db.url=jdbc:postgresql://${HDX_CPSDB_ADDR}:${HDX_CPSDB_PORT}/${HDX_CPSDB_DB}
db.username=${HDX_CPSDB_USER}
db.password=${HDX_CPSDB_PASS}

smtp.host=${HDX_SMTP_ADDR}
smtp.port=${HDX_SMTP_PORT}
mail.from=cps.${HDX_TYPE}@${HDX_DOMAIN}
