#-----------------------------------------------------------
# Control
#-----------------------------------------------------------

# Include file with .env variables if exists
-include .env

# Start containers
up:
	docker-compose -f ${COMPOSE_FILE} up -d

# Stop containers
down:
	docker-compose -f ${COMPOSE_FILE} down --remove-orphans

# Build containers
build:
	docker-compose -f ${COMPOSE_FILE} build

# Build and restart containers
update: build up

# Force the update process
update\:force:
	docker-compose -f ${COMPOSE_FILE} up -d --build --force-recreate

# Show list of running containers
ps:
	docker-compose -f ${COMPOSE_FILE} ps

# Restart containers
restart:
	docker-compose -f ${COMPOSE_FILE} restart

# Reboot containers
reboot: down up

# View output from containers
logs:
	docker-compose -f ${COMPOSE_FILE} logs

# Show logs of running containers with following output
fl:
	docker-compose -f ${COMPOSE_FILE} logs -f

# Init variables for development environment
env\:dev:
	cp ./.env.dev ./.env

# Init variables for production environment
env\:prod:
	cp ./.env.prod ./.env

# Create shared gateway network
gateway:
	docker network create gateway

# Prune stopped docker containers and dangling images
prune:
	docker system prune


#-----------------------------------------------------------
# App
#-----------------------------------------------------------

# Enter the app container
app:
	docker-compose -f ${COMPOSE_FILE} exec app bash

# Install yarn dependencies
yarn\:install:
	docker-compose -f ${COMPOSE_FILE} exec app yarn install

# Alias to install yarn dependencies
yi: yarn\:install

# Upgrade yarn dependencies
yarn\:upgrade:
	docker-compose -f ${COMPOSE_FILE} exec app yarn upgrade

# Alias to upgrade yarn dependencies
yu: yarn\:upgrade

# Show outdated yarn dependencies
yarn\:outdated:
	docker-compose exec -f ${COMPOSE_FILE} app yarn outdated

#-----------------------------------------------------------
# Swarm
#-----------------------------------------------------------

# Deploy the stack
swarm\:deploy:
	docker stack deploy --compose-file ${COMPOSE_FILE} client

# Remove/stop the stack
swarm\:rm:
	docker stack rm client

# List of stack services
swarm\:services:
	docker stack services client

# List the tasks in the stack
swarm\:ps:
	docker stack ps client

# Init the Docker Swarm Leader node
swarm\:init:
	docker swarm init


#-----------------------------------------------------------
# Danger zone
# Do not use these commands
#-----------------------------------------------------------

# Remove all app files and folders (leave only dockerized template)
danger\:app\:prune:
	sudo rm -rf .idea
	sudo rm -rf .vscode
	sudo rm -rf .nuxt
	sudo rm -rf assets
	sudo rm -rf layouts
	sudo rm -rf node_modules
	sudo rm -rf pages
	sudo rm -rf public
	sudo rm -rf store
	sudo rm -f .env
	sudo rm -f .gitignore
	sudo rm -f nuxt.config.ts
	sudo rm -f package.json
	sudo rm -f README.md
	sudo rm -f tsconfig.json
	sudo rm -f yarn.lock
