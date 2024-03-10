#!bin/sh

if [ ! -d "/var/lib/mysql/${DATABASE_NAME}" ]; then
        cat << EOF > /tmp/tmp_dbs.sql
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DATABASE_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${DATABASE_NAME};
CREATE USER IF NOT EXISTS '${DATABASE_USER}'@'%' IDENTIFIED BY '${DATABASE_USER_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DATABASE_NAME}.* TO '${DATABASE_USER}'@'%';
FLUSH PRIVILEGES;
EOF
        mariadbd --user=mysql --bootstrap < /tmp/tmp_dbs.sql
        rm -f /tmp/tmp_dbs.sql
fi

exec "$@"