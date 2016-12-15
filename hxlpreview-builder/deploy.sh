#!/bin/sh
#set -e

[ -n "${HXLP_BRANCH}" ] || HXLP_BRANCH=master

[ -n "${HXLP_PREFIX}" ] || HXLP_PREFIX=/hxlpreview/

echo "cleaning ${SRC_DIR}..."
rm -rf ${SRC_DIR}/*
cd ${SRC_DIR}

echo "cloning..."
git clone --branch ${HXLP_BRANCH} https://github.com/OCHA-DAP/hdx-hxl-preview.git code
[ "$?" -eq "0" ] || exit 1

echo "gathering deps..."
cd code
npm install
echo "building..."
ng build  --prod --bh ${HXLP_PREFIX}
echo "syncing over to ${DST}..."
rsync -avh --delete-after $SRC_DIR/dist/* $DST_DIR/
