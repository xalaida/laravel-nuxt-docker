# Image
FROM node:lts-alpine

# Set up work directory
WORKDIR /var/www/client

# Configure host
ENV HOST 0.0.0.0

# Expose the port
EXPOSE 3000

# Init command
CMD ["sh", "-c", "yarn install && yarn dev"]
