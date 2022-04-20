# Builder image
FROM composer:latest as builder

# Set up the working directory
WORKDIR /var/www/html

# Copy composer files
COPY ./composer.json ./composer.json
COPY ./composer.lock ./composer.lock

# Install composer dependencies
RUN composer install \
    --no-interaction \
    --no-dev \
    --ignore-platform-reqs \
    --no-scripts \
    --no-plugins

# Copy all files into the container
COPY ./ ./

# Dump composer autoload
RUN composer dump-autoload --optimize

# Serving image
FROM php:8.1-cli

# Update dependencies
RUN apt-get update \
# Install Zip
    && apt-get install -y libzip-dev zip \
    && docker-php-ext-install zip \
# Install Git
    && apt-get install -y git \
# Install Curl
    && apt-get install -y libcurl3-dev curl \
    && docker-php-ext-install curl \
# Install procps (required by Octane)
    && apt-get install -y procps \
# Install EXIF
    && docker-php-ext-install exif \
# Install GD
    && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    && docker-php-ext-configure gd --with-jpeg=/usr/include/ --with-freetype=/usr/include/ \
    && docker-php-ext-install gd \
# Install PostgreSQL
    && apt-get install -y libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql \
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
# Clean up the apt cache
    && rm -rf /var/lib/apt/lists/*

# Copy PHP configuration
COPY ./.docker/prod/base/php.ini "/${PHP_INI_DIR}/php.ini"
COPY ./.docker/prod/base/conf.d "/${PHP_INI_DIR}/conf.d"

# Set up the working directory
WORKDIR /var/www/html

# Copy files from builder image
COPY --from=builder /var/www/html ./

# Optimizing configuration loading
RUN php artisan config:cache \
# Optimizing route loading
    && php artisan route:cache \
# Optimizing view loading
    && php artisan view:cache \
# Optimizing event loading
    && php artisan event:cache \
# Generate storage symlink
    && php artisan storage:link
