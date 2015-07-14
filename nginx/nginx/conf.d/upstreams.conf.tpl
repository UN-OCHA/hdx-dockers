upstream ckan {
    server ${HDX_CKAN_ADDR}:${HDX_CKAN_PORT};
}

upstream blog {
    server ${HDX_BLOG_ADDR}:${HDX_BLOG_PORT};
}

upstream dataproxy {
    server ${HDX_DATAPROXY_ADDR}:${HDX_DATAPROXY_PORT};
}

#upstream ogre {
#    server ${HDX_OGRE_ADDR}:${HDX_OGRE_PORT};
#}

upstream gis {
    server ${HDX_GISAPI_ADDR}:${HDX_GISAPI_PORT};
}

upstream crisismap {
    server a.tile.openstreetmap.fr;
    server b.tile.openstreetmap.fr;
    server c.tile.openstreetmap.fr;
}

upstream cps {
    server ${HDX_CPS_ADDR}:${HDX_CPS_PORT};
}
