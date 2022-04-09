# Builder image
FROM api-base-prod:latest as builder

# Set up the working directory
WORKDIR /var/www/html

# Copy all files into the container (TODO: probably do not copy current storage folder)
COPY . .

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Install composer dependencies
RUN composer install --no-dev --no-interaction --optimize-autoloader

# Serving image
FROM api-base-prod

# Set up the working directory
WORKDIR /var/www/html

# Copy the built app
COPY --from=builder /var/www/html .

# Install Swoole (TODO: probably move into base image)
RUN pecl install swoole \
    && docker-php-ext-enable swoole

# PHP configuration (TODO: share between all php-related images)
COPY ./.docker/prod/app/php/php.ini "${PHP_INI_DIR}/php.ini"

# Copy environment variables (TODO: copy before the actual build)
COPY ./.env.prod .env

# Set up file ownership (TODO: optimize this part, slow exec)
RUN #chown -R www-data:www-data .
RUN chown -R storage bootstrap/cache

# Set up file permissions
RUN chmod 755 -R storage bootstrap/cache

# Optimizing configuration loading
RUN php artisan config:cache

# Optimizing route loading
RUN php artisan route:cache

# Optimizing view loading
RUN php artisan view:cache

# Export Octane port
EXPOSE 8000

# Run the Octane service
CMD ["php", "artisan", "octane:start", "--server=swoole", "--host=0.0.0.0", "--port=8000"]

# The health check configuration
HEALTHCHECK --start-period=5s --interval=2s --timeout=5s --retries=3 \
    CMD php artisan octane:status || exit 1
