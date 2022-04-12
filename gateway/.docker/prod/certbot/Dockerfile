# Image
FROM certbot/certbot:latest

# Install Curl
RUN apk add --update curl && \
    rm -rf /var/cache/apk/*

# Copy & enable cron configuration file
COPY ./crontab /etc/cron.d/crontab
RUN crontab /etc/cron.d/crontab

# Copy scripts
COPY ./scripts/ /scripts

# Set up permissions of scripts
RUN chmod -R +x /scripts

# Forward logs to docker logger collector
RUN touch /var/log/letsencrypt/letsencrypt.log
RUN ln -sf /dev/stdout /var/log/letsencrypt/letsencrypt.log

# Disable default certbot entrypoint
ENTRYPOINT []

# Run the cron service
CMD ["crond", "-f"]
