# Image
FROM node:16-alpine

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
