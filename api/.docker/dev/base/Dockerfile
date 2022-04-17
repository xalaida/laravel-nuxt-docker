# Image
FROM php:8.1-cli

# Starting from scratch
RUN apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Update dependencies
RUN apt-get update

# Install Zip
RUN apt-get install -y libzip-dev zip && docker-php-ext-install zip

# Install procps (required by Octane)
RUN apt-get install -y procps

# Install Git
RUN apt-get install -y git

# Install Curl
RUN apt-get install -y libcurl3-dev curl && docker-php-ext-install curl

# Install EXIF
RUN docker-php-ext-install exif

# Install GD
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    && docker-php-ext-configure gd --with-jpeg=/usr/include/ --with-freetype=/usr/include/ && docker-php-ext-install gd

# Install PostgreSQL
RUN apt-get install -y libpq-dev && docker-php-ext-install pdo pdo_pgsql

# Install PostgreSQL client (allows to back up database)
RUN apt-get install -y lsb-release wget gnupg \
    && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
    && echo "deb https://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
    && apt-get update && apt-get install -y postgresql-client-13

# Install BC Math
RUN docker-php-ext-install bcmath

# Install internationalization functions
RUN apt-get install -y zlib1g-dev libicu-dev g++ \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl

# Install Redis extension
RUN pecl install redis \
    && docker-php-ext-enable redis

# Install Process Control extenstion
RUN docker-php-ext-install pcntl \
    && docker-php-ext-enable pcntl

# Install OPcache extension
RUN docker-php-ext-install opcache

# Clean up
RUN apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy PHP configuration
COPY ./php/php.ini "${PHP_INI_DIR}/php.ini"
COPY ./php/opcache.ini "${PHP_INI_DIR}/opcache.ini"
