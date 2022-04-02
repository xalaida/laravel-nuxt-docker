#!/bin/bash

#
## 1. Delete all unnecessary files (with before published stubs) (if the "--clear" option is provided)
#

DELETE_OLD_FILES=false

for i in "$@" ; do
  if [[ $i == "--clear" ]] ; then
    DELETE_OLD_FILES=true
    break
  fi
done

if [ "${DELETE_OLD_FILES}" = true ]; then \
  # TODO: refactor to just remove everything except provided files

  # Remove old docker stubs
  if [ -d ./.docker ]; then
    sudo rm -rf ./.docker;
  fi

  # Remove temp app directory for installation
  if [ -d ./src ]; then
    sudo rm -rf ./src;
  fi

  if [ -d ./.git ]; then
    sudo rm -rf ./.git;
  fi

  if [ -d ./.nuxt ]; then
    sudo rm -rf ./.nuxt;
  fi

  if [ -d ./components ]; then
    sudo rm -rf ./components;
  fi

  if [ -d ./layouts ]; then
    sudo rm -rf ./layouts;
  fi

  if [ -d ./node_modules ]; then
    sudo rm -rf ./node_modules;
  fi

  if [ -d ./pages ]; then
    sudo rm -rf ./pages;
  fi

  if [ -d ./static ]; then
    sudo rm -rf ./static;
  fi

  if [ -d ./store ]; then
    sudo rm -rf ./store;
  fi

  if [ -f ./.env ]; then
    sudo rm ./.env;
  fi

  if [ -f ./.editorconfig ]; then
    sudo rm ./.editorconfig;
  fi

  if [ -f ./.gitignore ]; then
    sudo rm ./.gitignore;
  fi

  if [ -f ./nuxt.config.js ]; then
    sudo rm ./nuxt.config.js;
  fi

  if [ -f ./package.json ]; then
    sudo rm ./package.json;
  fi

  if [ -f ./README.md ]; then
    sudo rm ./README.md;
  fi

  if [ -f ./yarn.lock ]; then
    sudo rm ./yarn.lock;
  fi
fi;

#
## 2. Use the Nuxt 2 stubs
#

cp -r ./stubs/nuxt2/. ./.docker/


#
## 3. Remove old stubs (if option "--delete-stubs" is specified)
#

DELETE_STUBS=false

for i in "$@" ; do
  if [[ $i == "--delete-stubs" ]] ; then
    DELETE_STUBS=true
    break
  fi
done

if [ "${DELETE_STUBS}" = true ]; then \
  rm -rf ./stubs
fi


#
## 4. Copy .env file
#

if [ ! -f ./.env ]; then
    cp ./.env.local ./.env
fi

#
## 5. Build containers
#

docker-compose build


#
## 6. Init a new Nuxt app
#

# Init a new Nuxt app
docker-compose run --rm app yarn create nuxt-app src

# Set ownership of the app to the current user
sudo chown -R "$(id -u)":"$(id -g)" ./src

# Move all files and directories up one level
# TODO: rewrite without terminal errors
sudo mv ./src/* ./src/.* .

# Remove 'src' directory
sudo rm -r ./src


#
## TODO: print instructions what to do next (copy code to nuxt.config.js)
#
