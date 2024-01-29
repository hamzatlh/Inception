#!/bin/sh

cd /var/www/html/wordpress

# wp-config.php
wp core download --allow-root

wp core config --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=mariadb --allow-root

wp core install --url=${WORDPRESS_URL} --title=${WORDPRESS_TITLE} --admin_user=${WORDPRESS_ADMIN} --admin_password=${WORDPRESS_PASSWORD} --admin_email=${WORDPRESS_EMAIL} --allow-root

exec "$@"