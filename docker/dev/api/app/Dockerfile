# Image
FROM api-base:latest

# Starting from scratch
RUN apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
# Update dependencies
    && apt-get update \
# xDebug
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
# Swoole
    && pecl install swoole \
    && docker-php-ext-enable swoole \
# Clean up
    && apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# PHP configuration
COPY php.ini /usr/local/etc/php/php.ini

# Set up work directory
WORKDIR /var/www/api

# Export octane port
EXPOSE 8000

# Run the octane service
CMD ["php", "artisan", "octane:start", "--host=0.0.0.0", "--port=8000"]

# The health check configuration
HEALTHCHECK --start-period=5s --interval=2s --timeout=5s --retries=3 \
    CMD php artisan octane:status || exit 1
