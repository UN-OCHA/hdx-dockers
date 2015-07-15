DEBUG = False
APP_PORT = 5000
MAX_FILE_SIZE_MB = 300
TIMEOUT_SEC = 120
LOGGING_CONF_FILE = 'logging.conf'

DB_NAME = 'gis'
DB_USER = 'gis'
DB_HOST = 'db'

# gisapi url
GIS_API_PATTERN = 'http://${HDX_PREFIX}data.${HDX_DOMAIN}/gis/services/tables/{table_name}'
# ckan url to push back the reply
RESOURCE_UPDATE_API = 'http://${HDX_PREFIX}data.${HDX_DOMAIN}/api/action/hdx_resource_update_metadata'
# gispreviewbot's key
CKAN_API_KEY = '${HDX_GIS_API_KEY}'