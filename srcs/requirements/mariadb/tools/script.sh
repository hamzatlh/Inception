#!bin/sh

if [ ! -d "/var/lib/mysql/${DATABASE_NAME}" ]; then

        cat << EOF > /tmp/db.sql
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DATABASE_ROOT_PASSWORD}';
CREATE DATABASE ${DATABASE_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${DATABASE_USER}'@'%' IDENTIFIED by '${DATABASE_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DATABASE_NAME}.* TO '${DATABASE_USER}'@'%';
FLUSH PRIVILEGES;
EOF
        mariadbd --user=mysql --bootstrap < /tmp/db.sql
        rm -f /tmp/db.sql
else
        echo "Database already exists"
fi

exec "$@"