#!/bin/sh

WP_DB_NAME="wp_db"
DB_ROOT_PASSWD="rootPassword123"
DB_USER="wp_user"
DB_PASSWD="userPassword123"

echo " USE mysql;
        FLUSH PRIVILEGES;
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWD}';
        CREATE DATABASE ${WP_DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
        CREATE USER '${DB_USER}'@'%' IDENTIFIED by '${DB_PASSWD}';
        GRANT ALL PRIVILEGES ON ${WP_DB_NAME}.* TO '${DB_USER}'@'%';
        FLUSH PRIVILEGES;" | mariadbd --bootstrap
exec "$@"