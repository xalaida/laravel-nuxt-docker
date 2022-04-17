# Build arguments
ARG IMAGE_REGISTRY=prod
ARG IMAGE_TAG=latest

# Image
FROM ${IMAGE_REGISTRY}/api-base:${IMAGE_TAG}

# Set up the working directory
WORKDIR /var/www/html

# Run the queue service (TODO: set up retry and other parameters, or check if can be specified in the config/queue.php)
CMD ["php", "artisan", "queue:work"]
