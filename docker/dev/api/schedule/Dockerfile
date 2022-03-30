# Image
FROM api-base:latest

# Starting from scratch
RUN apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
# Update dependencies
    && apt-get update \
# Crontab
    && apt-get install -y cron \
# Clean up
    && apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set up a cron configuration file
COPY ./cron.d/crontab /etc/cron.d/crontab
RUN chmod 644 /etc/cron.d/crontab
RUN crontab /etc/cron.d/crontab

# Set up work directory
WORKDIR /var/www/api

# Command that runs with the container
CMD ["cron", "-f"]
