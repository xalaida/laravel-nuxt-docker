# CLI image
FROM php:8.3-cli as dev

# Retrieve APT lists
RUN apt-get update \
# Install Zip
  && apt-get install -y libzip-dev zip \
  && docker-php-ext-install zip \
# Install Git
  && apt-get install -y git \
# Install Swoole extension
  && pecl install swoole \
  && docker-php-ext-enable swoole \
# Install Process Control extension
  && docker-php-ext-install pcntl \
  && docker-php-ext-enable pcntl \
# Install PDO PGSQL extension
  && apt-get install -y libpq-dev \
  && docker-php-ext-install pdo pdo_pgsql \
# Install Redis extension
  && pecl install redis \
  && docker-php-ext-enable redis \
# Install Xdebug extension
  && pecl install xdebug \
  && docker-php-ext-enable xdebug \
# Remove APT lists
  && rm -rf /var/lib/apt/lists/*

# Install Composer package manager
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

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
