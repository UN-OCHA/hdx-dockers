upstream ckan {
    server 127.0.0.1:${HDX_CKAN_PORT};
}

upstream dataproxy {
    server 127.0.0.1:${HDX_DATAPROXY_PORT};
}

upstream crisismap {
    server a.tile.openstreetmap.fr;
    server b.tile.openstreetmap.fr;
    server c.tile.openstreetmap.fr;
}

upstream cps {
    server 127.0.0.1:${HDX_CPS_PORT};
}
