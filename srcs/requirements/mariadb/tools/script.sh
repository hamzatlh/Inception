#!/bin/sh

echo " USE mysql;
        FLUSH PRIVILEGES;
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWD}';
        CREATE DATABASE ${WP_DB_NAME};
        CREATE USER '${DB_USER}'@'%' IDENTIFIED by '${DB_PASSWD}';
        GRANT ALL PRIVILEGES ON ${WP_DB_NAME}.* TO '${DB_USER}'@'%';
        FLUSH PRIVILEGES;" | mariadbd --bootstrap
exec "$@"