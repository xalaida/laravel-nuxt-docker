# Image
FROM api-base:latest

# Starting from scratch
RUN apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Update dependencies
RUN apt-get update

# Install Crontab
RUN apt-get install -y cron

# Set up cron configuration file
COPY ./cron.d/crontab /etc/cron.d/crontab

# Configure cron service
RUN chmod 644 /etc/cron.d/crontab \
  && crontab /etc/cron.d/crontab

# Clean up
RUN apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set up work directory
WORKDIR /var/www/api

# Run the cron service
CMD ["cron", "-f"]
