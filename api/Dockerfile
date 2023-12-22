# Base image
FROM php:8.3-cli

# Retrieve lists of APT packages
RUN apt-get update \
# Install PDO PGSQL extension
  && apt-get install -y libpq-dev \
  && docker-php-ext-install pdo pdo_pgsql \
# Install Redis extension
  && pecl install redis \
  && docker-php-ext-enable redis \
# Clear APT cache
  && rm -rf /var/lib/apt/lists/*

# Install Composer package manager
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
