# Image
FROM node:17-alpine

# Install git
RUN apk add --no-cache git

# Set up work directory
WORKDIR /var/www/client

# Configure host
ENV HOST 0.0.0.0

# Expose the Nuxt port
EXPOSE 3000

# Export the Vite websocket port
EXPOSE 24678

# Init command
CMD ["sh", "-c", "yarn install && yarn dev -o"]
