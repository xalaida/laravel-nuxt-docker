# Builder image
FROM api-base:latest

# Set up the working directory
WORKDIR /var/www/html

# Export Octane port
EXPOSE 8000

# Run the Octane service
CMD ["php", "artisan", "octane:start", "--server=swoole", "--host=0.0.0.0", "--port=8000"]

# The health check configuration
HEALTHCHECK --start-period=5s --interval=2s --timeout=5s --retries=3 \
    CMD php artisan octane:status || exit 1
