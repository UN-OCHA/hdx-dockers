#!/bin/sh
#set -e

[ -n "${MPX_BRANCH}" ] || MPX_BRANCH=master
[ -n "${REPO_DIR}" ] || REPO_DIR=code

rm -rf ${SRC_DIR}
mkdir -p ${SRC_DIR}
cd ${SRC_DIR}

echo "cloning..."
git clone --branch ${MPX_BRANCH} https://github.com/OCHA-DAP/hdx-map-explorer.git code
[ "$?" -eq "0" ] || exit 1

echo "building..."
cd ${SRC_DIR}/${REPO_DIR}
npm install
bower --allow-root install
grunt default-no-tests

echo "syncing to ${DST} ..."
rsync -avh --delete $SRC_DIR/${REPO_DIR}/bin/* $DST_DIR/

echo "cleaning up..."
rm -rf ${SRC_DIR}/*

echo "done."
