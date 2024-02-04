#!/bin/sh

# Check if MariaDB data directory exists
if [ ! -d "/var/lib/mysql/test" ]; then
    # Create a temporary SQL file
    cat << EOF > /tmp/create_db.sql
FLUSH PRIVILEGES;
USE mysql;
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '';
CREATE DATABASE test;
CREATE USER 'test'@'%' IDENTIFIED BY '';
GRANT ALL PRIVILEGES ON test.* TO 'test'@'%';
FLUSH PRIVILEGES;
EOF

    # Stop MariaDB server
    service mariadb stop

    # Bootstrap MariaDB with the SQL script
    mariadbd --user=mysql --bootstrap < /tmp/create_db.sql

    # Remove temporary SQL file
    rm -f /tmp/create_db.sql

    # Start MariaDB server
    service mariadb start
fi

# Execute the provided command (e.g., starting a shell)
exec "$@"
