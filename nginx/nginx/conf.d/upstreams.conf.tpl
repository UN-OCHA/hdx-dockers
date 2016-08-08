upstream blog      { server ${HDX_BLOG_ADDR}:${HDX_BLOG_PORT}; }

upstream ckan      { server ${HDX_CKAN_ADDR}:${HDX_CKAN_PORT}; }

upstream cps       { server ${HDX_CPS_ADDR}:${HDX_CPS_PORT}; }

upstream dataproxy { server ${HDX_DATAPROXY_ADDR}:${HDX_DATAPROXY_PORT}; }

upstream hxlproxy  { server ${HDX_HXLPROXY_ADDR}:${HDX_HXLPROXY_PORT}; }

upstream gis       { server ${HDX_GISAPI_ADDR}:${HDX_GISAPI_PORT}; }

upstream gislayer  { server ${HDX_GISLAYER_ADDR}:${HDX_GISLAYER_PORT}; }

upstream solr1     { server ${HDX_SOLR_ADDR}:${HDX_SOLR_PORT}; }
# to do: make sure you pass the other db ip/port pair
upstream solr2     { server ${HDX_SOLR_ADDR}:${HDX_SOLR_PORT}; }
