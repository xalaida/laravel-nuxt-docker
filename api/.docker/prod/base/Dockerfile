# Builder image
FROM composer:latest as builder

# Set up the working directory
WORKDIR /var/www/html

# Copy composer files
COPY composer.json composer.json
COPY composer.lock composer.lock

# Allow installing by superuser
#ENV COMPOSER_ALLOW_SUPERUSER 1

# Install composer dependencies
RUN composer install \
    --no-interaction \
    --no-dev \
    # TODO: check if needed --ignore-platform-reqs \
    --no-scripts \
    --no-plugins

# Copy all files into the container
COPY . .

# Dump composer autoload
RUN composer dump-autoload \
    --optimize

# Serving image
FROM php:8.1-cli

# Starting from scratch
RUN apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
# Update dependencies
    && apt-get update \
# Install Zip
    && apt-get install -y libzip-dev zip && docker-php-ext-install zip \
# Install Git
    && apt-get install -y git \
# Install Curl
    && apt-get install -y libcurl3-dev curl && docker-php-ext-install curl \
# Install EXIF \
    && docker-php-ext-install exif \
# Install GD
    && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    && docker-php-ext-configure gd --with-jpeg=/usr/include/ --with-freetype=/usr/include/ \
    && docker-php-ext-install gd \
# Install PostgreSQL \
    && apt-get install -y libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql \
# Install PostgreSQL client (for database backups) (TODO: remove this and provide separate cron-based backup-container)
    && apt-get install -y lsb-release wget gnupg \
    && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
    && echo "deb https://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
    && apt-get update && apt-get install -y postgresql-client-13 \
# Install BC Math
    && docker-php-ext-install bcmath \
# Install internationalization functions \
    && apt-get install -y zlib1g-dev libicu-dev g++ \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
# Install Redis extension \
    && pecl install redis \
    && docker-php-ext-enable redis \
# Install Process Control extension \
    && docker-php-ext-install pcntl \
    && docker-php-ext-enable pcntl \
# Install Swoole \
    && pecl install swoole \
    && docker-php-ext-enable swoole \
# Clean up \
    && apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set up the working directory
WORKDIR /var/www/html

# Copy files from builder
COPY --from=builder /var/www/html .

# Copy environment variables (TODO: copy before the actual build)
# COPY ./.env.prod .env

# PHP configuration
COPY ./.docker/prod/base/php/php.ini "${PHP_INI_DIR}/php.ini"

# Optimizing configuration loading
RUN php artisan config:cache

# Optimizing route loading
RUN php artisan route:cache

# Optimizing view loading
RUN php artisan view:cache

# Set up file ownership (TODO: check if needed)
# RUN chown -R www-data:www-data bootstrap/cache
# RUN chown -R www-data:www-data storage

# TODO: optimize this part, slow exec
# RUN chown -R www-data:www-data .
# Set up file permissions
# RUN chmod 755 -R storage
# RUN chmod 755 -R storage bootstrap/cache
