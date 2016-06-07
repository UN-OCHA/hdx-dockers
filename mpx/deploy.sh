#!/bin/sh
set -e

[ -n "${MPX_BRANCH}" ] || MPX_BRANCH=master

rm -rf $SRC_DIR
mkdir -p $SRC_DIR
cd $SRC_DIR

echo "cloning..."
git clone https://github.com/OCHA-DAP/liverpool16.git .
[ "$?" -eq "0" ] || exit 1
echo "fetching..."
git fetch origin $MPX_BRANCH
[ "$?" -eq "0" ] || exit 1
echo "checking out..."
git checkout $MPX_BRANCH
[ "$?" -eq "0" ] || exit 1
echo "pulling..."
git pull
[ "$?" -eq "0" ] || exit 1

echo "building..."
chown -R www-data $SRC_DIR
su - www-data -c "npm install"
su - www-data -c "bower install"
su - www-data -c "grunt default-no-tests"

rsync -avh --delete $SRC_DIR/bin/* $DST_DIR/



