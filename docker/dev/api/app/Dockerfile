# Image
FROM api-base:latest

# Starting from scratch
RUN apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Update dependencies
RUN apt-get update

# Install xDebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Install Swoole
RUN pecl install swoole \
    && docker-php-ext-enable swoole

# Install Node (v16 LTS) & NPM
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm

# Install Chokidar (file watcher used by Octane)
RUN npm install --g chokidar

# Specify the node path (allow to require chokidar as global)
ENV NODE_PATH /usr/lib/node_modules

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# PHP configuration
COPY php.ini /usr/local/etc/php/php.ini

# Clean up
RUN apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set up work directory
WORKDIR /var/www/api

# Export octane port
EXPOSE 8000

# Run the octane service
CMD ["php", "artisan", "octane:start", "--server=swoole", "--host=0.0.0.0", "--port=8000", "--watch"]

# The health check configuration
HEALTHCHECK --start-period=5s --interval=2s --timeout=5s --retries=3 \
    CMD php artisan octane:status || exit 1
