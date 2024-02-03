#!/bin/sh

if [ ! -d "/var/lib/mysql/mysql" ]; then
    chown -R mysql:mysql /var/lib/mysql

    # init database
    mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm

    tfile=$(mktemp)
    if [ ! -f "$tfile" ]; then
        return 1
    fi
fi

if [ ! -d "/var/lib/mysql/wordpress" ]; then
    cat << EOF > /tmp/create_db.sql
USE mysql;
FLUSH PRIVILEGES;
CREATE DATABASE ${DATABASE_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${DATABASE_USER}'@'%' IDENTIFIED by '${DATABASE_USER_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DATABASE_NAME}.* TO '${DATABASE_USER}'@'%';
ALTER USER '${DATABASE_USER}'@'%' IDENTIFIED BY '${DATABASE_USER_PASSWORD}';
FLUSH PRIVILEGES;
EOF

    # run init.sql
    mariadbd --user=mysql --bootstrap < /tmp/create_db.sql
    rm -f /tmp/create_db.sql
fi
