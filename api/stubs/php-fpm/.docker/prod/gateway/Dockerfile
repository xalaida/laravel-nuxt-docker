# Image
FROM nginx:1.21-alpine

# Copy nginx configurations
COPY ./.docker/prod/gateway/nginx.conf /etc/nginx/nginx.conf
COPY ./.docker/prod/gateway/conf.d /etc/nginx/conf.d

# Copy public folder
COPY ./public /var/www/html/public
RUN rm /var/www/html/public/index.php
