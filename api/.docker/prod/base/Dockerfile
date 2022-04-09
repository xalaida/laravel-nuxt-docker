# Builder image
FROM api-php:latest as builder

# Set up the working directory
WORKDIR /var/www/html

# Copy all files into the container
COPY . .

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Install composer dependencies
RUN composer install --no-dev --no-interaction --optimize-autoloader

# Serving image
FROM api-php:latest

# Set up the working directory
WORKDIR /var/www/html

# Copy files from builder
COPY --from=builder /var/www/html .

# Copy environment variables (TODO: copy before the actual build)
COPY ./.env.prod .env

# PHP configuration
COPY ./.docker/prod/base/php/php.ini "${PHP_INI_DIR}/php.ini"

# Optimizing configuration loading
RUN php artisan config:cache

# Optimizing route loading
RUN php artisan route:cache

# Optimizing view loading
RUN php artisan view:cache

# Set up file ownership
RUN chown -R www-data:www-data bootstrap/cache
RUN chown -R www-data:www-data storage
# TODO: optimize this part, slow exec
# RUN chown -R www-data:www-data .
# Set up file permissions
# RUN chmod 755 -R storage
# RUN chmod 755 -R storage bootstrap/cache
