# Image
FROM node:16-alpine

# Update dependencies
RUN apk update \
# Install git
    && apk add --no-cache git \
# Install nuxi package
    && npm install -g nuxi

# Set up the working directory
WORKDIR /var/www/html

# Specify the host variable
ENV HOST 0.0.0.0

# Expose the Nuxt port
EXPOSE 3000

# Export the Vite websocket port
EXPOSE 24678

# Run the Nuxt service
CMD ["yarn", "dev", "-o"]
