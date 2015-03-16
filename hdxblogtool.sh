#!/bin/bash

if [ "$1" == "restore" ]; then
    blog_restore;
elif [ "$1" == "backup" ]; then
    dump_db;
    arch_files;
else
    me=$(basename $0)
    echo -en "\nUsage: $me [restore|backup]\n\n"
    exit 1
fi

server=${HDX_BACKUP_SERVER}
user=${HDX_BACKUP_USER}
srcdir=${HDX_BACKUP_BASE_DIR}
suffix=$(date +%Y%m%d-%H%M%S)
today=$(date +%Y%m%d)
basedir=/tmp/blog-restore
blogdir=/srv/www/docs
bloguser=${DB_ENV_MYSQL_PASS}
blogpass=${DB_ENV_MYSQL_PASS}
blogdb=${DB_ENV_MYSQL_DB}
blogconf=$blogdir/wp-config.php
backupdir=/srv/backup
preffix="prod"



function blog_restore() {

    mkdir -p $basedir
    cd $basedir
    rm -rf $basedir/*
    mkdir -p $blogdir
    rm -rf $blogdir/*
    # add in ssh keys for restore
    ssh_base_dir="/root/.ssh"
    [ -d $ssh_base_dir ] || mkdir -p $ssh_base_dir

    key_file=$ssh_base_dir"/id_rsa"
    ssh_key=${HDX_SSH_KEY}
    pub_file=$ssh_base_dir"/id_rsa.pub"
    ssh_pub=${HDX_SSH_PUB}
    if [ ! -f $key_file ]; then
        echo "SSH Key file not found. Creating..."
        ssh_key=$(echo $ssh_key | sed -e 's/-----BEGIN RSA PRIVATE KEY----- //')
        ssh_key=$(echo $ssh_key | sed -e 's/ -----END RSA PRIVATE KEY-----//')
        touch $key_file
        echo "-----BEGIN RSA PRIVATE KEY-----" >> $key_file
        for i in $ssh_key; do
            echo "$i" | sed -e 's/\"//' >> $key_file
        done
        echo "-----END RSA PRIVATE KEY-----" >> $key_file
    fi

    # fix perms of the ssh key
    status=$(stat $key_file | grep Uid)
    perms=$(echo $status | awk '{ print $2 }' | sed -e 's/^(//; s/\/.*//')
    owner=$(echo $status | awk '{ print $5 }' | sed -e 's/\/.*//')
    if [ "$owner" -ne "0" ]; then
        echo "Changing owner to root."
        chown root:root $key_file
    fi

    if [ "$perms" -ne "0600" ]; then
        echo "Changing perms to 0600."
        chmod 0600 $key_file
    fi

    if [ ! -f $pub_file ]; then
        echo "SSH Pub file not found. Creating..."
        echo "$ssh_pub" | sed -e 's/\"//' > $pub_file
    fi

    # sync backups
    echo "Getting the backup files..."
    rsync -av --progress $user@$server:$srcdir/prod/prod.blog.$today* . 
    echo "Done."
    # stop fpm
    echo "Stopping fpm"
    sv stop fpm
    echo "Done."

    # restore last blog archive
    echo "Restore files ... please wait."
    mkdir -p $blogdir
    rm -rf $blogdir/*
    last_blog_files_save=$(ls -1 prod.blog.$today*.tar.gz -t | head -n 1)
    tar xzf $last_blog_files_save -C $blogdir
    echo "Done."
    # clean up
    echo "Removing files archive..."
    rm -rf $basedir/prod.blog*.tar.gz
    echo "Done."

    # change db details
    echo "Change db credentials in wp-config.php"
    sed -i "s/define('DB_NAME'.*/define('DB_NAME', '$blogdb');/" $blogconf;
    sed -i "s/define('DB_USER'.*/define('DB_USER', '$bloguser');/" $blogconf;
    sed -i "s/define('DB_PASSWORD'.*/define('DB_PASSWORD', '$blogpass');/" $blogconf;
    sed -i "s/define('DB_HOST'.*/define('DB_HOST', 'db');/" $blogconf;
    echo "Done."

    # add prefix on hardcoded urls
    echo "Adding prefix to hardlinks... please wait."
    for file in $(find $blogdir -type f); do
        if [ "$(file $file | grep -c ASCII\ text)" -eq "1" ]; then
            for name in docs data manage; do
                for proto in https https; do
                    sed -i "s/$proto:\/\/[a-zA-Z0-9\-]*$name.${HDX_DOMAIN}/$proto:\/\/${HDX_PREFIX}$name.${HDX_DOMAIN}/g" $file
                done
            done
        fi
    done
    echo "Done."

    # restore last db save
    last_blog_db_save=$(ls -1 prod.blog.$today*.sql.gz -t | head -n 1)
    gunzip $last_blog_db_save
    last_blog_db_save=$(echo $last_blog_db_save | sed 's/\.gz//')
    #new_url=${HDX_PREFIX}docs.${HDX_DOMAIN}
    #new_data_url=${HDX_PREFIX}data.${HDX_DOMAIN}
    # replace prod url with your url
    echo "Adding the prefix to database content..."
    for name in docs data manage; do
        new_url=${HDX_PREFIX}$name.${HDX_DOMAIN}
        for proto in http https; do
            sed -i "s/$proto:\/\/[a-zA-Z0-9\-]*$name.${HDX_DOMAIN}/$proto:\/\/$new_url/g" $last_blog_db_save
        done
    done
    echo "Done."

    echo "Dropping and recreating database... please wait."
    echo "drop database ${DB_ENV_MYSQL_DB}; create database ${DB_ENV_MYSQL_DB}" | \
        mysql -h db -u $bloguser -p$blogpass
    echo "Done."

    echo "Restoring database... please wait."
    #sed -i "s/http:\/\/[a-zA-Z0-9\-]*docs\.hdx\.rwlabs\.org/http:\/\/$new_url/g" $last_blog_db_save
    #sed -i "s/http:\/\/[a-zA-Z0-9\-]*data\.hdx\.rwlabs\.org/http:\/\/$new_data_url/g" $last_blog_db_save
    #sed -i "s/https:\/\/[a-zA-Z0-9\-]*docs\.hdx\.rwlabs\.org/https:\/\/$new_url/g" $last_blog_db_save
    #sed -i "s/https:\/\/[a-zA-Z0-9\-]*data\.hdx\.rwlabs\.org/https:\/\/$new_data_url/g" $last_blog_db_save
    cat $last_blog_db_save | mysql -h db -u $bloguser -p$blogpass
    echo "Done."

    echo "Starting fpm"
    sv start fpm
    echo "Done."

    echo "Removing temporary restore directory..."
    rm -rf $basedir
    echo "Done."

    echo "Restore completed!"
}

function dump_db {
    #mysqldump --user=$user --password=$pass --extended-insert=FALSE --add-drop-database $db > $bkdir/$preffix.$db.$suffix.sql
    mysqldump --user=$bloguser --password=$blogpass --add-drop-database -B $blogdb > $backupdir/$preffix.$blogdb.$suffix.sql
    gzip $backupdir/*sql
}

function arch_files {
    tar czf $backupdir/$preffix.$blogdb.$suffix.tar.gz -C $blogdir .
}
