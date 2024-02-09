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

COPY ./tools/script.sh /script.sh

RUN chmod +x /script.sh

ENTRYPOINT ["/script.sh"]

CMD ["/usr/sbin/php-fpm8.2", "-F"]
