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

# Imagick
RUN apt-get update && apt-get install -y libmagickwand-dev --no-install-recommends && rm -rf /var/lib/apt/lists/*
# Version is not officially released https://pecl.php.net/get/imagick but following works for PHP 8
RUN mkdir -p /usr/src/php/ext/imagick; \
    curl -fsSL https://github.com/Imagick/imagick/archive/06116aa24b76edaf6b1693198f79e6c295eda8a9.tar.gz | tar xvz -C "/usr/src/php/ext/imagick" --strip 1; \
    docker-php-ext-install imagick;

# PostgreSQL
ADD https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions /usr/local/bin/

RUN chmod uga+x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions pdo_pgsql

# BC Math
RUN docker-php-ext-install bcmath

# Human Language and Character Encoding Support
RUN apt-get install -y zlib1g-dev libicu-dev g++
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl

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
