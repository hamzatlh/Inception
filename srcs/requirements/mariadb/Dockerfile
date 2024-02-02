FROM debian:bookworm

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y mariadb-server && apt-get install -y mariadb-client

RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld && chmod 755 /run/mysqld

COPY ./tools/script.sh /script.sh

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

EXPOSE 3306

ENTRYPOINT ["sh", "/script.sh"]

CMD ["mariadbd"]

