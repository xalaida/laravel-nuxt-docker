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
# Install cron
    && apt-get install -y cron \
# Clean up
    && apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy and enable cron job file
COPY ./.docker/prod/schedule/cron.d/crontab /etc/cron.d/crontab
RUN crontab /etc/cron.d/crontab

# Set up the working directory
WORKDIR /var/www/html

# Run the cron service
CMD ["cron", "-f"]
