# Image
FROM node:16

# Starting from scratch
RUN apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Update dependencies
RUN apt-get update

# Install git
RUN apt-get install -y git

# Install nuxi package
RUN npm install -g nuxi

# Clean up
RUN apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set up work directory
WORKDIR /var/www/html

# Expose the Nuxt port
EXPOSE 3000

# Export the Vite websocket port
EXPOSE 24678

# Run the Nuxt service
CMD ["yarn", "dev", "-o"]
