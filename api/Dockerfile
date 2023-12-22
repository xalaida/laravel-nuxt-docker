# Base image
FROM php:8.3-cli

# Retrieve APT lists
RUN apt-get update \
# Install Zip (required for Composer)
  && apt-get install -y libzip-dev zip \
  && docker-php-ext-install zip \
# Install Git (required for Composer)
  && apt-get install -y git \
# Install PDO PGSQL extension (required for Postgres connection)
  && apt-get install -y libpq-dev \
  && docker-php-ext-install pdo pdo_pgsql \
# Install Redis extension (required for Redis connection)
  && pecl install redis \
  && docker-php-ext-enable redis \
# Remove APT lists
  && rm -rf /var/lib/apt/lists/*

# Install Composer package manager
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
