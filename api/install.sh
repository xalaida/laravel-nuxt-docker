#!/bin/bash

# Build the API containers
docker-compose build

# Init a new Laravel app
docker-compose run app composer create-project --prefer-dist laravel/laravel src

# Set ownership of the app to the current user
sudo chown -R "$(id -u)":"$(id -g)" ./src
# Move all files and directories up one level
# TODO: rewrite without terminal errors
mv src/* src/.* .

# Remove 'src directory
rm -r src

# Copy .env file
if [ ! -f ./.env ]; then
    cp ./.env.dev ./.env
fi

# Generate the app key
docker-compose run app php artisan key:generate --ansi

# Install Swoole
docker-compose run app composer require laravel/octane
docker-compose run --user "$(id -u)":"$(id -g)" app php artisan octane:install --server=swoole

# Install breeze
INSTALL_BREEZE=true

# TODO: install it by condition
if [ ${INSTALL_BREEZE} ]; then
    docker-compose run app composer require laravel/breeze --dev
    docker-compose run --user "$(id -u)":"$(id -g)" app php artisan breeze:install api
fi

# Stop containers
docker-compose down

# Print the final message
echo "Laravel has been installed"
