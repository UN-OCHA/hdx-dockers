#!/bin/sh
#set -e

[ -n "${SRC_DIR}" ] || SRC_DIR=/src
[ -n "${DST_DIR}" ] || DST_DIR=/dst
[ -n "${HXLP_BRANCH}" ] || HXLP_BRANCH=master
[ -n "${HXLP_PREFIX}" ] || HXLP_PREFIX=/hxlpreview/

REPO_DIR=code
echo "cleaning ${SRC_DIR}..."
rm -rf ${SRC_DIR}/*
cd ${SRC_DIR}

echo "cloning..."
git clone --branch ${HXLP_BRANCH} https://github.com/OCHA-DAP/hdx-hxl-preview.git ${SRC_DIR}/${REPO_DIR}
[ "$?" -eq "0" ] || exit 1

cd code
echo "linking some heavier global packages locally to save time and power..."
npm link node-gyp
npm link node-sass
npm link node-zopfli
npm link angular
npm link angular-cli
echo "gathering deps..."
npm install
echo "building..."
ng build  --prod --bh ${HXLP_PREFIX}
echo "syncing over to ${DST}..."
rsync -avh --delete-after ${SRC_DIR}/${REPO_DIR}/dist/* ${DST_DIR}/
