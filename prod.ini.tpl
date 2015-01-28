[DEFAULT]
debug = false

[server:main]
use = egg:Paste#http
host = 0.0.0.0
port = 9221

[app:main]
use = egg:ckan
use = config:/srv/ckan/common-config-ini.txt
## Database Settings
sqlalchemy.url = postgresql://ckan:ckan@db:5432/ckan
ckan.datastore.write_url = postgresql://ckan:ckan@db:5432/datastore
ckan.datastore.read_url = postgresql://datastore:datastore@db:5432/datastore

## Site Settings
ckan.site_url = http://${HDX_PREFIX}data.${HDX_DOMAIN}
beaker.session.secret = 2yD+TJxTgW+VtA38OzxQJNPPO
app_instance_uuid = {0bcda427-a808-470f-a141-37eb1ac46ba1}

## Search Settings
ckan.site_id = default
solr_url = http://solr:8983/solr/ckan
#ckan.simple_search = 1

ckan.recaptcha.publickey = 6LfoIfMSAAAAADKSmGKOsRggVKv4CAOm2yqJoeto
ckan.recaptcha.privatekey = ${HDX_CKAN_RECAPTCHA_KEY}

ckan.tracking_enabled = true

## Email settings

email_to = ckan.${HDX_TYPE}@${HDX_DOMAIN}
error_email_from = ckan.${HDX_TYPE}@${HDX_DOMAIN}
smtp_server = 172.17.42.1
smtp.server = 172.17.42.1
smtp.starttls = False

hdx.cache.onstartup = true

hdx.orgrequest.email = hdx.feedback@gmail.com
hdx.orgrequest.sendmails = true 

hdx.datapreview.url = /dataproxy
hdx.previewmap.url = /tiles/{z}/{x}/{y}.png
hdx.crisismap.url = /crisis-tiles/{z}/{x}/{y}.png

hdx.rest.indicator.endpoint = http://${HDX_PREFIX}manage.${HDX_DOMAIN}/public/api2/values
hdx.rest.indicator.endpoint.facets = http://${HDX_PREFIX}manage.${HDX_DOMAIN}/public/api2

ofs.storage_dir = ${HDX_FILESTORE}
ckan.storage_path = ${HDX_FILESTORE}

## Logging configuration
[loggers]
keys = root, ckan, ckanext

[handlers]
keys = console, file

[formatters]
keys = generic

[logger_root]
level = WARNING
handlers = console, file

[logger_ckan]
level = WARNING
handlers = console, file
qualname = ckan
propagate = 0

[logger_ckanext]
level = WARNING
handlers = console, file
qualname = ckanext
propagate = 0

[handler_console]
class = StreamHandler
args = (sys.stderr,)
level = NOTSET
formatter = generic

[handler_file]
class = FileHandler
args = ('/var/log/ckan/ckan.pain.log','a')
level = NOTSET
formatter = generic

[formatter_generic]
format = %(asctime)s %(levelname)-5.5s [%(name)s] %(message)s
