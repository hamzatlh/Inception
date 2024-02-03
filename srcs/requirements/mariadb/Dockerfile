FROM debian:bookworm

RUN apt update && apt upgrade -y && apt install -y mariadb-server && apt install -y mariadb-client

RUN mkdir /var/run/mysqld; \
chmod 777 /var/run/mysqld; \
chown -R mysql:mysql /var/run/mysqld;

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306

USER mysql
COPY ./tools/script.sh /script.sh
ENTRYPOINT ["sh", "script.sh"]
CMD ["mariadb"]