FROM debian:bookworm

RUN apt-get install -y php7.3 \
	php7.3-fpm \
	php7.3-mysql \
	mariadb-client \
	nginx curl

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/script.sh /script.sh

COPY ./conf/default.conf  /etc/php/7.3/fpm/pool.d/

RUN chmod +x /script.sh

RUN mkdir -p /run/php

ENTRYPOINT ["sh", "script.sh"]

CMD ["php-fpm7.3", "-R", "-F"]

