#!/bin/bash

# Copy .env file
if [ ! -f ./.env ]; then
    cp ./.env.dev ./.env
fi

# Create shared gateway network (TODO: create only if missing)
docker network create gateway

# Build base container
docker build -f ./.docker/dev/base/Dockerfile -t api-base-dev .

# Build the API containers
docker-compose -f docker-compose.dev.yml build

# Init a new Laravel app
docker-compose -f docker-compose.dev.yml run --rm app composer create-project --prefer-dist laravel/laravel src

# Set ownership of the app to the current user
sudo chown -R "$(id -u)":"$(id -g)" ./src

# Remove default .env file
rm src/.env

# Move app from the src directory to the current directory
# TODO: rewrite without terminal errors
mv src/* src/.* .

# Remove 'src directory
rm -r src

# Generate the app key
docker-compose -f docker-compose.dev.yml run --rm app php artisan key:generate --ansi

# Install Swoole
docker-compose -f docker-compose.dev.yml run --rm app composer require laravel/octane
docker-compose -f docker-compose.dev.yml run --rm --user "$(id -u)":"$(id -g)" app php artisan octane:install --server=swoole

# Install breeze
INSTALL_BREEZE=true

# TODO: install it conditionally
if [ ${INSTALL_BREEZE} ]; then
    docker-compose -f docker-compose.dev.yml run --rm app composer require laravel/breeze --dev
    docker-compose -f docker-compose.dev.yml run --rm --user "$(id -u)":"$(id -g)" app php artisan breeze:install api
fi

# Print the final message
echo "Laravel has been installed"
