#!/bin/sh
set -e

mkdir -p $SRC_DIR
cd $SRC_DIR
#git status > /dev/null 2>&1
#if [ $? -eq 0 ]; then
#    git checkout $BRANCH
#    git pull
#else
#    rm -rf $SRC_DIR/*
#    git clone https://github.com/OCHA-DAP/liverpool16.git .
#    git checkout $BRANCH
#fi

git clone https://github.com/OCHA-DAP/liverpool16.git .
git checkout master
#$BRANCH

chown -R www-data $SRC_DIR
su - www-data -c "npm install"
su - www-data -c "bower install"
su - www-data -c "grunt default-no-tests"

rsync -avh --delete $SRC_DIR/bin/* $DST_DIR/



