#!/bin/sh

if [ ! -d "/var/www/html/wordpress" ]; then
    mkdir -p /var/www/html/wordpress
fi

cd /var/www/html/wordpress
rm -rf /var/www/html/wordpress/*

wp core download --allow-root

wp config create --allow-root --dbname=${WP_DB_NAME} --dbuser=${WP_USER} --dbpass=${WP_PASSWD} --dbhost=${WP_HOST}

wp core install --allow-root --url=${WP_URL} --title=${WP_TITLE} --admin_user=${WP_ADMIN} --admin_password=${WP_ADMIN_PASSWD} --admin_email=${WP_ADMIN_EMAIL}

exec "$@"
