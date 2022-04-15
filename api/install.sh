#!/bin/bash

install_laravel() {
  local DIRECTORY=src

  # Init a new Laravel app into a temporary directory
  docker-compose -f docker-compose.dev.yml run --rm app \
      composer create-project --prefer-dist laravel/laravel ${DIRECTORY}

  # Set ownership of the temporary directory to the current user
  sudo chown -R "$(id -u)":"$(id -g)" ./${DIRECTORY}

  # Remove the default file with environment variables
  rm ${DIRECTORY}/.env

  # Move everything from the temporary directory to the current directory
  # TODO: rewrite without terminal errors
  mv ${DIRECTORY}/* ${DIRECTORY}/.* .

  # Remove the temporary directory
  rm -r ${DIRECTORY}

  # Generate the application key
  make key:generate
}

install_breeze() {
    # Require Breeze package
    docker-compose -f docker-compose.dev.yml run --rm app \
        composer require laravel/breeze --dev

    # Install Breeze package
    docker-compose -f docker-compose.dev.yml run --rm \
        --user "$(id -u)":"$(id -g)" app \
        php artisan breeze:install api
}

install_octane() {
  # Require Octane package
  docker-compose -f docker-compose.dev.yml run --rm app \
      composer require laravel/octane

  # Install Octane package
  docker-compose -f docker-compose.dev.yml run --rm \
      --user "$(id -u)":"$(id -g)" app \
      php artisan octane:install --server=swoole
}

# Copy .env file
make env:dev

# Create shared gateway network
make network

# Build containers
make build:all

install_laravel
install_octane
install_breeze

# Start containers
make up

# Print the final message
echo "The API app has been installed and run on http://localhost:8000."
