#!/bin/bash

# Specify variables
ENV_DIST_FILE=.env.dev
ENV_FILE=.env
DOCKER_NETWORK=gateway
COMPOSE_FILE=docker-compose.dev.yml
CONTAINER=app
TEMP_INSTALL_DIRECTORY=src

# Copy .env file from the dist
if [ ! -f $ENV_FILE ]; then
    cp $ENV_DIST_FILE $ENV_FILE
fi

#todo provide --nuxt2 option that automatically copies stubs

# Create shared gateway network
docker network create $DOCKER_NETWORK

# Build containers
docker compose -f $COMPOSE_FILE build

# Init a new Nuxt app into a temporary directory
docker-compose -f $COMPOSE_FILE run --rm --no-deps \
  --user "$(id -u)":"$(id -g)" $CONTAINER \
  npx nuxi init $TEMP_INSTALL_DIRECTORY

# Set ownership of the temporary directory to the current user
sudo chown -R "$(id -u)":"$(id -g)" $TEMP_INSTALL_DIRECTORY

# Move everything from the temporary directory to the current directory
mv $TEMP_INSTALL_DIRECTORY/* $TEMP_INSTALL_DIRECTORY/.* .

# Remove the temporary directory
rm -r $TEMP_INSTALL_DIRECTORY

# Install packages
docker-compose -f $COMPOSE_FILE run --rm --no-deps \
  --user "$(id -u)":"$(id -g)" $CONTAINER \
  yarn install

# Start containers
docker-compose -f $COMPOSE_FILE up -d

# Print the final message
echo "The client app has been installed and run on http://localhost:3000."
