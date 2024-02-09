#!bin/sh

if [ ! -d "/var/lib/mysql/${DATABASE_NAME}" ]; then

        cat << EOF > /tmp/db.sql
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DATABASE_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${DATABASE_NAME} DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER IF NOT EXISTS '${DATABASE_USER}'@'%' IDENTIFIED BY '${DATABASE_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DATABASE_NAME}.* TO '${DATABASE_USER}'@'%';
FLUSH PRIVILEGES;
EOF
        mariadbd --user=mysql --bootstrap < /tmp/db.sql
        rm -f /tmp/db.sql
else
        echo "Database already exists"
fi

exec "$@"