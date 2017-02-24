#!/bin/sh

# tail -f /var/log/*

cd /srv/mapexplorer && npm install && bower install --allow-root
cd /srv/mapexplorer && grunt watch