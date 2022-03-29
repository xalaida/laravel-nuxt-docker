# Image
FROM php:8.0-cli

# Starting from scratch
RUN apt-get clean
RUN apt-get -y autoremove
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Dependencies
RUN apt-get update

# ---- Unique for supervisor only ---->

# Prepare log files
RUN touch /var/log/cron.log
RUN touch /var/log/queue.log
RUN touch /var/log/supervisord.log

# Supervisor
RUN apt-get install -y supervisor

# Add supervisor configuration
COPY supervisord.conf /etc/supervisor/supervisord.conf

# Crontab
RUN apt-get install -y cron
COPY cron.d/schedule /etc/cron.d
RUN chmod -R 644 /etc/cron.d
RUN crontab /etc/cron.d/schedule

# <---- Unique for supervisor only ----

# Zip
RUN apt-get install -y libzip-dev zip && docker-php-ext-configure zip && docker-php-ext-install zip

# Curl
RUN apt-get install -y libcurl3-dev curl && docker-php-ext-install curl

# GD
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev
RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/
RUN docker-php-ext-install gd

# PostgreSQL
RUN apt-get install -y libpq-dev && docker-php-ext-install pdo pdo_pgsql

# BC Math
RUN docker-php-ext-install bcmath

# Human Language and Character Encoding Support
RUN apt-get install -y zlib1g-dev libicu-dev g++ \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl

# Custom php.ini config
COPY php.ini /usr/local/etc/php/php.ini

# ---- Unique for supervisor only ---->

# Removed lines for installing composer
# Removed lines for installing xDebug

# <---- Unique for supervisor only ----

# Clean up
RUN apt-get clean
RUN apt-get -y autoremove
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ---- Unique for supervisor only ---->

# Set up default directory
WORKDIR /etc/supervisor/conf.d/

# Run after container is up
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
