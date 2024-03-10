#!/bin/sh

echo "Checking ..."
if [ ! -d "/var/www/html/wordpress" ]; then
    mkdir -p /var/www/html/wordpress
fi

echo "<<< <<< Creating wordpress ..."
cd /var/www/html/wordpress
rm -rf /var/www/html/wordpress/*

echo "<<< <<< Installing wordpress ..."
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

echo "<<< <<< Downloading wordpress ..."
wp core download --allow-root

echo "<<< <<< Creating wordpress config ..."
wp config create --allow-root --dbname=${DATABASE_NAME} --dbuser=${DATABASE_USER} --dbpass=${DATABASE_ROOT_PASSWORD} --dbhost=${DATABASE_HOST} --dbprefix=${DATABASE_PREFIX}

echo "<<< <<< Installing wordpress ..."
wp core install --allow-root --url=${WP_URL} --title=${WP_TITLE} --admin_user=${WP_ADMIN} --admin_password=${WP_ADMIN_PASSWD} --admin_email=${WP_ADMIN_EMAIL}

echo "<<< <<< Creating user ..."
wp user create --allow-root ${WP_USER} ${WP_EMAIL} --user_pass=${WP_PASSWORD} --role=author
exec "$@"
