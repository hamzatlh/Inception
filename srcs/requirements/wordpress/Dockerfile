FROM debian:bookworm

RUN apt update && apt upgrade -y && apt install -y php8.2 \
    php8.2-fpm \
    php8.2-mysql \
    mariadb-client \
    mariadb-server \
    nginx curl

RUN ln -sf /usr/bin/php8.2 /usr/bin/php


RUN mkdir -p /var/www/html/wordpress \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

RUN mkdir -p /run/php

COPY ./tools/script.sh /script.sh

RUN chmod +x /script.sh

RUN mv /script.sh /usr/bin/

CMD ["script.sh"]

# CMD ["/usr/sbin/php-fpm8.2", "-R", "-F"]
