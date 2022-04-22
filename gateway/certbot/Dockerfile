# Image
FROM certbot/certbot:v1.26.0

# Install Curl & jq
RUN apk add --update curl jq && \
    rm -rf /var/cache/apk/*

# Copy & enable cron configuration file
COPY ./cron.d/crontab /etc/cron.d/crontab
RUN crontab /etc/cron.d/crontab

# Copy scripts
COPY ./scripts/ /scripts

# Set up permissions of scripts
RUN chmod -R +x /scripts

# Disable default certbot entrypoint
ENTRYPOINT []

# Run the cron service
CMD ["crond", "-f"]
