# Base stage
FROM php:8.3-cli as base

# Retrieve APT lists
RUN apt-get update \
# Install APT packages
    && apt-get install -y  \
# Install ZIP library
    libzip-dev \
# Install ZIP binary
    zip \
# Install Git binary
    git \
# Install PostgresSQL library
    libpq-dev \
# Remove APT lists
    && rm -rf /var/lib/apt/lists/*

# Install Composer binary
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install PDO PGSQL extension
RUN docker-php-ext-install pdo pdo_pgsql

# Install Redis extension
RUN pecl install redis \
    && docker-php-ext-enable redis

# Install ZIP extension
RUN docker-php-ext-install zip

# Install Process Control extension
RUN docker-php-ext-install pcntl \
    && docker-php-ext-enable pcntl

# Install Swoole extension
RUN pecl install swoole \
    && docker-php-ext-enable swoole

# Install OPcache extension
RUN docker-php-ext-install opcache

# Configure OPcache environment variables
ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS="0"

# Copy OPcache configuration file
COPY ./platform/php/conf.d/opcache.ini "${PHP_INI_DIR}/conf.d/opcache.ini"

# Copy PHP configuration file
COPY ./platform/php/php.ini "${PHP_INI_DIR}/php.ini"

# Specify working directory
WORKDIR /app

# Dev stage
FROM base AS base-dev

# Install Node.js
COPY --from=node:21-slim /usr/lib /usr/lib
COPY --from=node:21-slim /usr/local/share /usr/local/share
COPY --from=node:21-slim /usr/local/lib /usr/local/lib
COPY --from=node:21-slim /usr/local/include /usr/local/include
COPY --from=node:21-slim /usr/local/bin /usr/local/bin
COPY --from=node:21-slim /opt /opt

# Install Chokidar module
RUN npm install -g chokidar

# Configure node_mobules path
ENV NODE_PATH /usr/local/lib/node_modules

# Install Xdebug extension
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Build stage
FROM base AS build

# Copy application files
COPY --chown=www-data:www-data . .

# Install Composer dependencies
RUN composer install \
    --no-interaction \
    --no-dev \
    --optimize-autoloader

# Specify production environment
ENV APP_ENV=production

# Optimize config loading
RUN php artisan config:cache \
# Optimize route loading
    && php artisan route:cache \
# Optimize view loading
    && php artisan view:cache \
# Optimize event loading
    && php artisan event:cache
