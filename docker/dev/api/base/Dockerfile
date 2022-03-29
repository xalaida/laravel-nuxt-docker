# Image
FROM php:8.1-fpm

# Starting from scratch
RUN apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
# Update dependencies
    && apt-get update \
# Zip
    && apt-get install -y libzip-dev zip && docker-php-ext-install zip \
# Git
    && apt-get install -y git \
# Curl
    && apt-get install -y libcurl3-dev curl && docker-php-ext-install curl \
# EXIF
    && docker-php-ext-install exif \
# GD
    && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    && docker-php-ext-configure gd --with-jpeg=/usr/include/ --with-freetype=/usr/include/ && docker-php-ext-install gd \
# PostgreSQL
    && apt-get install -y libpq-dev && docker-php-ext-install pdo pdo_pgsql \
# PostgreSQL client (allows to back up database)
    && apt-get install -y lsb-release wget gnupg \
    && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
    && echo "deb https://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
    && apt-get update && apt-get install -y postgresql-client-13 \
# BC Math
    && docker-php-ext-install bcmath \
# Human Language and Character Encoding Support
    && apt-get install -y zlib1g-dev libicu-dev g++ \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
# PHP Redis extension
    && pecl install redis \
    && docker-php-ext-enable redis \
# Process Control
    && docker-php-ext-install pcntl \
    && docker-php-ext-enable pcntl \
# Clean up
    && apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
