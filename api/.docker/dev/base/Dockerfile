# Image
FROM php:8.1-cli

# Starting from scratch
RUN apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Update dependencies
Run apt-get update

# Zip
RUN apt-get install -y libzip-dev zip && docker-php-ext-install zip

# Git
RUN apt-get install -y git

# Curl
RUN apt-get install -y libcurl3-dev curl && docker-php-ext-install curl

# EXIF
RUN docker-php-ext-install exif

# GD
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    && docker-php-ext-configure gd --with-jpeg=/usr/include/ --with-freetype=/usr/include/ && docker-php-ext-install gd

# PostgreSQL
RUN apt-get install -y libpq-dev && docker-php-ext-install pdo pdo_pgsql

# PostgreSQL client (allows to back up database)
RUN apt-get install -y lsb-release wget gnupg \
    && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
    && echo "deb https://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
    && apt-get update && apt-get install -y postgresql-client-13

# BC Math
RUN docker-php-ext-install bcmath

# Human Language and Character Encoding Support
RUN apt-get install -y zlib1g-dev libicu-dev g++ \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl

# PHP Redis extension
RUN pecl install redis \
    && docker-php-ext-enable redis

# Process Control
RUN docker-php-ext-install pcntl \
    && docker-php-ext-enable pcntl

# Clean up
RUN apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
