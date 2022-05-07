#!/bin/bash

install_laravel() {
  local INSTALL_DIRECTORY=src

  # Init a new Laravel app into a temporary directory
  docker-compose -f docker-compose.dev.yml run --rm --no-deps app \
    composer create-project --prefer-dist laravel/laravel ${INSTALL_DIRECTORY}

  # Set ownership of the temporary directory to the current user
  sudo chown -R "$(id -u)":"$(id -g)" ./${INSTALL_DIRECTORY}

  # Remove the default file with environment variables
  rm ${INSTALL_DIRECTORY}/.env

  # Move everything from the temporary directory to the current directory
  mv ${INSTALL_DIRECTORY}/* ${INSTALL_DIRECTORY}/.* .

  # Remove the temporary directory
  rm -r ${INSTALL_DIRECTORY}

  # Generate the application key
  docker-compose -f docker-compose.dev.yml run --rm --no-deps app \
    php artisan key:generate --ansi
}

install_breeze() {
    # Require Breeze package
    docker-compose -f docker-compose.dev.yml run --rm --no-deps app \
      composer require laravel/breeze --dev

    # Install Breeze package
    docker-compose -f docker-compose.dev.yml run --rm --no-deps \
      --user "$(id -u)":"$(id -g)" app \
      php artisan breeze:install api
}

install_octane() {
  # Require Octane package
  docker-compose -f docker-compose.dev.yml run --rm --no-deps app \
    composer require laravel/octane

  # Install Octane package
  docker-compose -f docker-compose.dev.yml run --rm --no-deps \
    --user "$(id -u)":"$(id -g)" app \
    php artisan octane:install --server=swoole
}

# Copy a .env file if it is missing
if [ ! -f ./.env ]; then
  cp ./.env.dev ./.env
fi

# Create shared gateway network
docker network create gateway

# Build containers
make build.all

# Install Laravel framework
install_laravel

# Install Octane package
install_octane

# Install Breeze package
install_breeze

# Start containers
make up

# Print the final message
echo "The API app has been installed and run on http://localhost:8000."
