DEBUG = False
APP_PORT = 5000
MAX_FILE_SIZE_MB = 100
TIMEOUT_SEC = 120

DB_NAME = 'gis'
DB_USER = 'gis'
DB_HOST = 'db'

GIS_API_PATTERN = 'http://${HDX_GISAPI_ADDR}:${HDX_GISAPI_PORT}/services/tables/{table_name}'

LOGGING_CONF_FILE = 'logging.conf'

# Needed to push the results back to CKAN (you can have this on public but.. beware dns resolution :(
RESOURCE_UPDATE_API = 'http://${HDX_CKAN_ADDR}:${HDX_CKAN_PORT}/api/action/hdx_resource_update_metadata'

# No worries, this is a dummy api key - replace it with CJ's bot API KEY!!!
CKAN_API_KEY = '${HDX_GIS_API_KEY}'
