# Image
FROM api-base-prod:latest

# Set up the working directory
WORKDIR /var/www/html

# Run the queue service
CMD ["php", "artisan", "queue:work"]
