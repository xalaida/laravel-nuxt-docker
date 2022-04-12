# Image
FROM certbot/certbot:latest

# Copy & enable cron configuration file
COPY ./crontab /etc/cron.d/crontab
RUN crontab /etc/cron.d/crontab

# Copy scripts
COPY ./scripts/ /scripts

# Set up permissions of scripts
RUN chmod -R +x /scripts

# Disable default certbot entrypoint
ENTRYPOINT []

# Run the cron service
CMD ["crond", "-f"]
