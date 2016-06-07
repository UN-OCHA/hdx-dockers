#!/bin/sh
set -e

[ -n "${MPX_BRANCH}" ] || MPX_BRANCH=master

mkdir -p $SRC_DIR
cd $SRC_DIR

rm -rf $SRC_DIR/*
git clone https://github.com/OCHA-DAP/liverpool16.git .
git fetch origin $MPX_BRANCH
[ -z "$?" ] || exit 1
git checkout $MPX_BRANCH
[ -z "$?" ] || exit 1
git pull
[ -z "$?" ] || exit 1

chown -R www-data $SRC_DIR
su - www-data -c "npm install"
su - www-data -c "bower install"
su - www-data -c "grunt default-no-tests"

rsync -avh --delete $SRC_DIR/bin/* $DST_DIR/



