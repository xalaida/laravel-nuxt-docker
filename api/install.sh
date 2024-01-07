#!/bin/bash

set -e

COMPOSE_FILE=compose.local.yaml
APP_SERVICE=app
REVERSE_PROXY_NETWORK=reverse-proxy
TEMP_DIR=tmp

install_laravel() {
    docker compose -f $COMPOSE_FILE run --rm --no-deps --user $(id -u):$(id -g) $APP_SERVICE \
        composer create-project --prefer-dist laravel/laravel $TEMP_DIR

    rm README.md
    rm $TEMP_DIR/.env
    rm $TEMP_DIR/.env.example

    shopt -s dotglob

    mv $TEMP_DIR/* .

    rm -r $TEMP_DIR
}

install_octane() {
    docker compose -f $COMPOSE_FILE run --rm --no-deps $APP_SERVICE \
        composer require laravel/octane

    docker compose -f $COMPOSE_FILE run --rm --no-deps \
        --user $(id -u):$(id -g) $APP_SERVICE \
        php artisan octane:install --server=swoole
}

install_flysystem_s3() {
    docker compose -f $COMPOSE_FILE run --rm --no-deps $APP_SERVICE \
        composer require league/flysystem-aws-s3-v3 "^3.0" --with-all-dependencies
}

docker network create --driver bridge $REVERSE_PROXY_NETWORK || true

docker compose -f $COMPOSE_FILE build

install_laravel

install_octane

install_flysystem_s3

docker compose -f $COMPOSE_FILE up -d

if [ "$1" == "--destruct" ]; then
    echo "Removing installation script"
    rm ./install.sh
fi

echo "The API app has been installed and run on http://localhost:8000."
