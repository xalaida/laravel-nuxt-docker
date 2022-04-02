# Image
FROM node:16

# Update dependencies
RUN apt-get update

# Install git
RUN apt-get install -y git

# Clean up
RUN apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose the Nuxt port
EXPOSE 3000

# Set up work directory
WORKDIR /var/www/html

# Run the Nuxt service
CMD ["yarn", "dev"]
