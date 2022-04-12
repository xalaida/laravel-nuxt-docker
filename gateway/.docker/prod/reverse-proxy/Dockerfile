# Image
FROM nginx:1.21

# Add nginx configurations
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./snippets /etc/nginx/snippets
COPY ./sites-internal /etc/nginx/sites-internal
COPY ./sites-enabled /etc/nginx/sites-enabled

# Folder for built templates
ENV NGINX_ENVSUBST_OUTPUT_DIR /etc/nginx/sites-enabled
