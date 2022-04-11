# Image
FROM certbot/certbot:latest

# Copy cron configuration file
COPY ./crontab /etc/cron.d/crontab

# Enable cron configuration file
RUN crontab /etc/cron.d/crontab

# Copy scripts
COPY ./scripts/ /scripts

# Set up scripts permissions
RUN chmod -R +x /scripts

# Run the cron service
CMD ["cron", "-f"]
