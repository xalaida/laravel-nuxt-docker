#!/bin/bash

set -e

COMPOSE_FILE=compose.local.yaml
APP_SERVICE=app
REVERSE_PROXY_NETWORK=reverse-proxy
TEMP_DIR=tmp

install_nuxt() {
    docker compose -f $COMPOSE_FILE run --rm --no-deps --user $(id -u):$(id -g) $APP_SERVICE \
        npx -y nuxi@latest init --packageManager npm $TEMP_DIR

    shopt -s dotglob

    mv $TEMP_DIR/* .

    rm -r $TEMP_DIR
}

docker network create --driver bridge $REVERSE_PROXY_NETWORK || true

docker compose -f $COMPOSE_FILE build

install_nuxt

docker compose -f $COMPOSE_FILE run --rm --no-deps --user $(id -u):$(id -g) $APP_SERVICE \
    npm install

docker compose -f $COMPOSE_FILE up -d

if [ "$1" == "--destruct" ]; then
    echo "Removing installation script"
    rm ./install.sh
fi

echo "The web app has been installed and run on http://localhost:3000."
