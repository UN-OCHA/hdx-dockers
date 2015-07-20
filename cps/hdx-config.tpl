ckan.host = ${HDX_PREFIX}data.${HDX_DOMAIN}
ckan.technical.api.key = ${HDX_CKAN_API_KEY}

db.url=jdbc:postgresql://${HDX_CPSDB_ADDR}:${HDX_CPSDB_PORT}/cps
db.username=cps
db.password=cps

smtp.host=${HDX_SMTP_ADDR}
smtp.port=${HDX_SMTP_PORT}
mail.from=cps.${HDX_TYPE}@${HDX_DOMAIN}
