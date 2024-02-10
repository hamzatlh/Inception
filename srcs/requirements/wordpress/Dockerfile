FROM debian:bookworm

RUN apt update && apt upgrade -y && apt install -y php8.2 \
    php8.2-fpm \
    php8.2-mysql \
    mariadb-client \
    mariadb-server \
    curl \ 
    sendmail

RUN mkdir -p /var/www/html/wordpress \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

RUN mkdir -p /run/php

RUN sed -i "s|listen = /run/php/php8.2-fpm.sock|listen = 0.0.0.0:9000|g" /etc/php/8.2/fpm/pool.d/www.conf

COPY ./tools/script.sh /script.sh

RUN chmod +x /script.sh

EXPOSE 9000

ENTRYPOINT ["sh","script.sh"]

CMD ["php-fpm8.2", "-R", "-F"]
