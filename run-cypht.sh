#!/bin/bash

PATH_VARLIB=/var/lib/hm3
for DIR in attachments users app_data; do
    mkdir --parents $PATH_VARLIB/$DIR
done
chown -R www-data $PATH_VARLIB

cd /usr/local/share/cypht
php ./scripts/config_gen.php

echo "Preparing SQlite database"
sqlite3 /var/lib/hm3/users/db <<SQL
create table if not exists hm_user_session(
    hm_id varchar(250),
    data longblob,
    date timestamp,
    primary key (hm_id)
);
create table if not exists hm_user(
    username varchar(250),
    hash varchar(250),
    primary key (username)
);
create table if not exists hm_user_settings(
    username varchar(250),
    settings longblob,
    primary key (username)
);
SQL
chown www-data:www-data /var/lib/hm3/users/db

echo "Starting up web server"
rm -f /var/www/html/cypht
ln -s /usr/local/share/cypht/site /var/www/html/cypht
service apache2 start

echo "Ready!"
cat /dev/full
