#-----------------------------------------------------------
# Docker
#-----------------------------------------------------------

# Start containers
up:
	docker-compose up -d

# Stop containers
down:
	docker-compose down --remove-orphans

# Show the status of each container
ps:
	docker-compose ps

# Restart containers
restart: down up

# Show logs of each container
logs:
	docker-compose logs

# Show following logs of each container
fl:
	docker-compose logs -f


#-----------------------------------------------------------
# App
#-----------------------------------------------------------

# Enter into the app container
app:
	docker-compose exec app bash


#-----------------------------------------------------------
# Dependencies
#-----------------------------------------------------------

# Install yarn dependencies
yarn\:install:
	docker-compose exec app yarn install

# Alias to install yarn dependencies
yi: yarn\:install

# Upgrade yarn dependencies
yarn\:upgrade:
	docker-compose exec app yarn upgrade

# Alias to upgrade yarn dependencies
yu: yarn\:upgrade

# Show outdated yarn dependencies
yarn\:outdated:
	docker-compose exec app yarn outdated


#-----------------------------------------------------------
# Installation
#-----------------------------------------------------------

# Create shared client network
network:
	docker network create client

# Build containers
build:
	docker-compose build

# Build containers without cache
rebuild:
	docker-compose build --no-cache


#-----------------------------------------------------------
# Production
#-----------------------------------------------------------

# Create the 'client' docker network
prod\:network:
	docker network create client

# Build production containers
prod\:build:
	docker-compose -f docker-compose.prod.yml build

# Start production containers
prod\:up:
	docker-compose -f docker-compose.prod.yml up -d

# Stop production containers
prod\:down:
	docker-compose -f docker-compose.prod.yml down --remove-orphans

# Restart the gateway
prod\:gateway\:restart:
	cd ../gateway; make prod:restart

# Upgrade prod environment
prod\:upgrade: prod\:build prod\:up prod\:gateway\:restart


#-----------------------------------------------------------
# Swarm
#-----------------------------------------------------------

# Deploy the stack
prod\:swarm\:deploy:
	docker stack deploy --compose-file docker-compose.prod.yml client

# Remove/stop the stack
prod\:swarm\:rm:
	docker stack rm client

# List of stack services
prod\:swarm\:services:
	docker stack services client

# List the tasks in the stack
prod\:swarm\:ps:
	docker stack ps client

# Init the Docker Swarm Leader node
prod\:swarm\:init:
	docker swarm init
