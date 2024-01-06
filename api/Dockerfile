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
# Install Process monitoring package
    procps \
# Remove APT lists
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions using PECL
RUN pecl install \
# Install Swoole extension
    swoole \
# Install Redis extension
    redis \
# Compile PHP extensions
    && docker-php-ext-install \
# Compile PDO extension
    pdo \
# Compile PGSQL extension
    pdo_pgsql \
# Compile Process Control extension
    pcntl \
# Compile Opcache extension
    opcache \
# Enable PHP extensions
    && docker-php-ext-enable \
# Enable Swoole extension
    swoole \
# Enable Redis extension
    redis \
# Enable Process Control extension
    pcntl

# Install Composer binary
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy PHP configuration file
COPY .platform/php/php.ini $PHP_INI_DIR/php.ini

# Copy OPcache configuration file
COPY .platform/php/conf.d/opcache.ini $PHP_INI_DIR/conf.d/opcache.ini

# Configure OPcache environment variables
ENV OPCACHE_ENABLE=disable
ENV OPCACHE_ENABLE_CLI=0
ENV OPCACHE_JIT=tracing

# Specify working directory
WORKDIR /app

# Dev stage
FROM base AS base-dev

# Install Xdebug extension
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Copy Xdebug configuration file
COPY .platform/php/conf.d/xdebug.ini ${PHP_INI_DIR}/conf.d/xdebug.ini

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
ENV NODE_PATH=/usr/local/lib/node_modules

# Build stage
FROM base AS build

# Specify environment variable for .env file
ENV APP_ENV=production

# Configure OPcache environment variables
ENV OPCACHE_ENABLE=1
ENV OPCACHE_ENABLE_CLI=1
ENV OPCACHE_JIT=tracing

# Copy application files
COPY --chown=www-data:www-data . .

# Specify filesystem permissions
RUN chmod -R 775 bootstrap/cache storage

# Install Composer dependencies
RUN composer install \
    --no-interaction \
    --no-dev \
    --optimize-autoloader

# Optimize config loading
RUN php artisan config:cache \
# Optimize route loading
    && php artisan route:cache \
# Optimize view loading
    && php artisan view:cache \
# Optimize event loading
    && php artisan event:cache
