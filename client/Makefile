# Include file with .env variables if exists
-include .env

# Define default values for variables
COMPOSE_FILE ?= docker-compose.yml

#-----------------------------------------------------------
# Management
#-----------------------------------------------------------

# Create shared gateway network
gateway:
	docker network create gateway

# Init variables for development environment
env.dev:
	cp ./.env.dev ./.env

# Init variables for production environment
env.prod:
	cp ./.env.prod ./.env

# Build and restart containers
install: build up

# Start containers
up:
	docker-compose -f ${COMPOSE_FILE} up -d

# Stop containers
down:
	docker-compose -f ${COMPOSE_FILE} down --remove-orphans

# Build containers
build:
	docker-compose -f ${COMPOSE_FILE} build

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
	docker-compose -f ${COMPOSE_FILE} logs --tail 500

# Follow output from containers (short for 'follow logs')
fl:
	docker-compose -f ${COMPOSE_FILE} logs --tail 500 -f

# Prune stopped docker containers and dangling images
prune:
	docker system prune

#-----------------------------------------------------------
# Application
#-----------------------------------------------------------

# Enter the app container
app.bash:
	docker-compose -f ${COMPOSE_FILE} exec app /bin/bash

# Install yarn dependencies
yarn.install:
	docker-compose -f ${COMPOSE_FILE} exec app yarn install

# Alias to install yarn dependencies
yi: yarn.install

# Upgrade yarn dependencies
yarn.upgrade:
	docker-compose -f ${COMPOSE_FILE} exec app yarn upgrade

# Alias to upgrade yarn dependencies
yu: yarn.upgrade

# Show outdated yarn dependencies
yarn.outdated:
	docker-compose exec -f ${COMPOSE_FILE} app yarn outdated

#-----------------------------------------------------------
# Swarm
#-----------------------------------------------------------

# Deploy the stack
swarm.deploy:
	docker stack deploy --compose-file ${COMPOSE_FILE} client

# Remove/stop the stack
swarm.rm:
	docker stack rm client

# List of stack services
swarm.services:
	docker stack services client

# List the tasks in the stack
swarm.ps:
	docker stack ps client

# Init the Docker Swarm Leader node
swarm.init:
	docker swarm init

#-----------------------------------------------------------
# Danger zone
# Do not use these commands
#-----------------------------------------------------------

# Remove all app files and folders (leave only dockerized template)
danger.app.prune:
	sudo rm -rf \
		.idea \
		.vscode \
		.nuxt \
		assets \
		components \
		layouts \
		node_modules \
		pages \
		public \
		static \
		store \
		.editorconfig \
		.env \
		app.vue \
		.gitignore \
		nuxt.config.js \
		nuxt.config.ts \
		package.json \
		README.md \
		tsconfig.json \
		yarn.lock
