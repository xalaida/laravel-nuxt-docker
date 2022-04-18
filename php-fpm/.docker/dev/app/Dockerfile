# Build arguments
ARG IMAGE_REGISTRY=dev
ARG IMAGE_TAG=latest

# Base image
FROM ${IMAGE_REGISTRY}/api-base:${IMAGE_TAG} as base

# Serving image
FROM php:8.1-fpm

# Update dependencies
RUN apt-get update \
# Install Zip
    && apt-get install -y libzip-dev zip && docker-php-ext-install zip \
# Install Git
    && apt-get install -y git \
# Install Curl
    && apt-get install -y libcurl3-dev curl && docker-php-ext-install curl \
# Install EXIF
    && docker-php-ext-install exif \
# Install GD
    && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    && docker-php-ext-configure gd --with-jpeg=/usr/include/ --with-freetype=/usr/include/ && docker-php-ext-install gd \
# Install PostgreSQL
    && apt-get install -y libpq-dev && docker-php-ext-install pdo pdo_pgsql \
# Install BC Math
    && docker-php-ext-install bcmath \
# Install internationalization functions
    && apt-get install -y zlib1g-dev libicu-dev g++ \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
# Install Redis extension
    && pecl install redis \
    && docker-php-ext-enable redis \
# Install Process Control extension
    && docker-php-ext-install pcntl \
    && docker-php-ext-enable pcntl \
# Install OPcache extension
    && docker-php-ext-install opcache \
# Install Xdebug
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
# Clean up the apt cache
    && rm -rf /var/lib/apt/lists/*

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Copy PHP configurations
COPY --from=base "/${PHP_INI_DIR}/php.ini" "/${PHP_INI_DIR}/php.ini"
COPY --from=base "/${PHP_INI_DIR}/conf.d" "/${PHP_INI_DIR}/conf.d"
COPY ./.docker/dev/app/conf.d "/${PHP_INI_DIR}/conf.d"

# Set up the working directory
WORKDIR /var/www/html
