# Image
FROM nginx:1.21-alpine

# Copy nginx configurations
COPY ./.docker/prod/gateway/nginx.conf /etc/nginx/nginx.conf
COPY ./.docker/prod/gateway/conf.d /etc/nginx/conf.d

# Copy public folder
COPY ./public /var/www/html/public

# Expose a port of the gateway server
EXPOSE 8000

# Expose a port of the status server
EXPOSE 8001
