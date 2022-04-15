# Build arguments
ARG IMAGE_REGISTRY=prod
ARG IMAGE_TAG=latest

# Image
FROM ${IMAGE_REGISTRY}/api-base:${IMAGE_TAG}

# Starting from scratch
RUN apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
# Update dependencies
    && apt-get update \
# Install Swoole \
    && pecl install swoole \
    && docker-php-ext-enable swoole \
# Clean up
    && apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set up the working directory
WORKDIR /var/www/html

# Run the Octane service
CMD ["php", "artisan", "octane:start", "--server=swoole", "--host=0.0.0.0", "--port=8000", "--max-requests=1000"]

# The health check configuration
HEALTHCHECK --start-period=5s --interval=5s --timeout=5s --retries=3 \
    CMD php artisan octane:status || exit 1
