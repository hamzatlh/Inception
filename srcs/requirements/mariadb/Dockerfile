FROM debian:bookworm

RUN apt update && apt upgrade -y && apt install -y mariadb-server && apt install -y mariadb-client

# RUN mkdir -p /var/lib/mysql; \
#     chown -R mysql:mysql /var/lib/mysql


RUN mkdir -p /var/run/mysqld && chmod 777 /var/run/mysqld

# COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306

COPY ./tools/script.sh /script.sh

ENTRYPOINT ["sh", "script.sh"]

CMD ["mariadbd", "--user=root", "--bind-address=0.0.0.0"]