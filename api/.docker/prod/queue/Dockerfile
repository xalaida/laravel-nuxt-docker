# Image
FROM ${IMAGE_REGISTRY:-local}/api-base:${IMAGE_TAG:-latest}

# Set up the working directory
WORKDIR /var/www/html

# Run the queue service
CMD ["php", "artisan", "queue:work"]
