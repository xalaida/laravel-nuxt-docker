#!/bin/bash

# Copy .env file
if [ ! -f ./.env ]; then
    cp ./.env.dev ./.env
fi

# Create shared gateway network (TODO: create only if missing)
docker network create gateway

# Build the client containers
docker-compose -f docker-compose.dev.yml build

# Init a new Nuxt app
docker-compose -f docker-compose.dev.yml run --rm --user "$(id -u)":"$(id -g)" app npx nuxi init src

# Set ownership of the app to the current user
chown -R "$(id -u)":"$(id -g)" ./src

# Move all files and directories up one level
# TODO: rewrite without terminal errors
mv src/* src/.* .

# Remove 'src directory
rm -r src

# Install packages
docker-compose -f docker-compose.dev.yml run --rm --user "$(id -u)":"$(id -g)" app yarn install

# Print the final message
echo "Nuxt has been installed"
