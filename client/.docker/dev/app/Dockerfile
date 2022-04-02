# Image
FROM node:17-alpine

# Install git
RUN apk add --no-cache git

# Install nuxi package
RUN npm install -g nuxi

# Set up work directory
WORKDIR /var/www/

# Configure host
ENV HOST 0.0.0.0

# Expose the Nuxt port
EXPOSE 3000

# Export the Vite websocket port
EXPOSE 24678

# Run the Nuxt service
CMD ["yarn", "dev", "-o"]
