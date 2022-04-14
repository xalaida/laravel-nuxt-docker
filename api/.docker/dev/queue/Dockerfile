# Build arguments
ARG IMAGE_REGISTRY=dev
ARG IMAGE_TAG=latest

# Image
FROM ${IMAGE_REGISTRY}/api-base:${IMAGE_TAG}

# Set up the working directory
WORKDIR /var/www/html

# Run the queue service
CMD ["php", "artisan", "queue:work"]
