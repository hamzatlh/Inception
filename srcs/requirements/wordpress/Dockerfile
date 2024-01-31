FROM debian:bookworm

# Install required packages
RUN apt update && apt upgrade -y && apt install -y php8.2 \
    php8.2-fpm \
    php8.2-mysql \
    mariadb-client \
    nginx curl

RUN ln -s /usr/bin/php8.2 /usr/bin/php


# Create the directory with correct ownership and permissions
RUN mkdir -p /var/www/html/wordpress \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Install WP CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# Copy the script
COPY ./tools/script.sh /script.sh

# Create a directory for PHP-FPM to store the socket file
RUN mkdir -p /run/php

# Set the entry point
ENTRYPOINT ["sh", "script.sh"]

# Start PHP-FPM
CMD ["/usr/sbin/php-fpm8.2", "-R", "-F"]
