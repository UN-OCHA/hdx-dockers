#!/bin/bash

server=${HDX_BACKUP_SERVER}
user=${HDX_BACKUP_USER}
srcdir=${HDX_BACKUP_BASE_DIR}
today=$(date +%Y%m%d)
basedir=/srv
blogdir=/srv/www/docs

cd $basedir

# setup the keys
mkdir -p /root/.ssh
echo ${HDX_SSH_PUB} > /root/.ssh/id_rsa.pub
echo ${HDX_SSH_KEY} > /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa
chown root:root -R /root

# sync backups
rsync -av --progress $user@$server:$scrdir/prod.blog.$today* . 

# restore last blog archive
mkdir -p $blogdir
rm -rf $blogdir/*
last_blog_files_save=$(ls -l prod.blog.$today*.tar.gz -t | head -n 1)
tar xvf $last_blog_files_save -C $blogdir
# clean up
rm -rf $basedir/prod.blog*.tar.gz

# restore last db save
last_blog_db_save=$(ls -l prod.blog.$today*.sql.gz -t | head -n 1)
gunzip $last_blog_db_save
last_blog_db_save=$(echo $last_blog_db_save | sed 's/\.gz//')
new_url=${HDX_PREFIX}docs.${HDX_DOMAIN}
# replace prod url with your url
sed -i "s/http:\/\/[a-zA-Z0-9\-]*docs\.hdx\.rwlabs\.org/$new_url/" $last_blog_db_save
cat $last_blog_db_save | mysql -u $bloguser -p$blogpass

echo "Done!"
