#!/bin/sh
set -e

mkdir -p $SRC_DIR
cd $SRC_DIR
git status > /dev/null 2>&1
if [ $? -eq 0 ]; then
    git checkout $BRANCH
    git pull
else
    rm -rf $SRC_DIR/*
    git clone https://github.com/OCHA-DAP/liverpool16.git .
    git checkout $BRANCH
fi

chown -R www-data $SRC_DIR
su - www-data npm install
su - www-data bower install
su - www-data grunt default-no-tests

rsync -avh --delete $SRC_DIR/* $DST_DIR/



