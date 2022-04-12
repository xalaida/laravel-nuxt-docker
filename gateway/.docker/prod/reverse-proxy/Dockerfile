# Image
FROM nginx:1.21

# Add nginx configurations
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./sites-enabled /etc/nginx/sites-enabled
COPY ./snippets /etc/nginx/snippets
COPY ./templates /etc/nginx/templates

# Folder for built templates
ENV NGINX_ENVSUBST_OUTPUT_DIR /etc/nginx/sites-enabled
