#-----------------------------------------------------------
# Environment variables
#-----------------------------------------------------------

# Include file with .env variables if exists
-include .env

# Define default values for variables
COMPOSE_FILE ?= docker-compose.yml
BASE_IMAGE_DOCKERFILE ?= ./.docker/prod/base/Dockerfile
IMAGE_REGISTRY ?= prod
IMAGE_TAG ?= latest

#-----------------------------------------------------------
# Control
#-----------------------------------------------------------

# Start containers
up:
	docker-compose -f ${COMPOSE_FILE} up -d

# Stop containers
down:
	docker-compose -f ${COMPOSE_FILE} down --remove-orphans

# Build containers
build:
	docker-compose -f ${COMPOSE_FILE} build

# Build all containers
build\:all: build\:base build

# Build the base app image
build\:base:
	docker build --file ${BASE_IMAGE_DOCKERFILE} --tag ${IMAGE_REGISTRY}/api-base:${IMAGE_TAG} .

# Build and restart containers
update: build\:all up

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

# Prune stopped docker containers and dangling images
prune:
	docker system prune


#-----------------------------------------------------------
# App
#-----------------------------------------------------------

# Enter the app container
app:
	docker-compose -f ${COMPOSE_FILE} exec app /bin/bash

# Run the tinker service
tinker:
	docker-compose -f ${COMPOSE_FILE} exec app php artisan tinker

# Clear the app cache
cache\:clear:
	docker-compose -f ${COMPOSE_FILE} exec app php artisan cache:clear

# Migrate the database
db\:migrate:
	docker-compose -f ${COMPOSE_FILE} exec app php artisan migrate

# Alias to migrate the database
migrate: db\:migrate

# Rollback the database
db\:rollback:
	docker-compose -f ${COMPOSE_FILE} exec app php artisan migrate:rollback

# Seed the database
db\:seed:
	docker-compose -f ${COMPOSE_FILE} exec app php artisan db:seed

# Fresh the database state
db\:fresh:
	docker-compose -f ${COMPOSE_FILE} exec app php artisan migrate:fresh

# Dump database into file (only for development environment) #TODO: replace file name with env variable
db\:dump:
	docker-compose -f ${COMPOSE_FILE} exec postgres pg_dump -U ${DB_USERNAME} -d ${DB_DATABASE} > ./.docker/postgres/dumps/dump.sql

# TODO: add command to import db dump

# Restart the queue process
queue\:restart:
	docker-compose -f ${COMPOSE_FILE} exec queue php artisan queue:restart

# Generate the app key
key:
	docker-compose -f ${COMPOSE_FILE} exec app php artisan key:generate --ansi

# Generate a symlink to the storage directory
storage:
	docker-compose -f ${COMPOSE_FILE} exec app php artisan storage:link --relative

# Install composer dependencies
composer\:install:
	docker-compose -f ${COMPOSE_FILE} exec app composer install

# Alias to install composer dependencies
ci: composer\:install

# Update composer dependencies
composer\:update:
	docker-compose -f ${COMPOSE_FILE} exec app composer update

# Alias to update composer dependencies
cu: composer\:update

# Show outdated composer dependencies
composer\:outdated:
	docker-compose -f ${COMPOSE_FILE} exec app composer outdated

# PHP composer autoload command
composer\:autoload:
	docker-compose -f ${COMPOSE_FILE} exec app composer dump-autoload

# Set up permissions for cache and storage folders
permissions:
	sudo chmod -R 755 bootstrap/cache
	sudo chmod -R 755 storage


#-----------------------------------------------------------
# Testing (only for development environment)
#-----------------------------------------------------------

# Run phpunit tests (requires 'phpunit/phpunit' composer package)
test:
	docker-compose -f ${COMPOSE_FILE} exec app ./vendor/bin/phpunit --order-by=defects --stop-on-defect

# Alias to run phpunit tests
t: test

# Run phpunit tests with the coverage mode (TODO: install PCOV or other lib)
coverage:
	docker-compose -f ${COMPOSE_FILE} exec app ./vendor/bin/phpunit --coverage-html ./.coverage

# Run dusk tests (requires 'laravel/dusk' composer package)
dusk:
	docker-compose -f ${COMPOSE_FILE} exec app php artisan dusk

# Generate code metrics (requires 'phpmetrics/phpmetrics' composer package)
metrics:
	docker-compose -f ${COMPOSE_FILE} exec app ./vendor/bin/phpmetrics --report-html=./.metrics api/app


#-----------------------------------------------------------
# Redis
#-----------------------------------------------------------

# Enter the redis container
redis:
	docker-compose -f ${COMPOSE_FILE} exec redis redis-cli

# Flush the redis state
redis\:flush:
	docker-compose -f ${COMPOSE_FILE} exec redis redis-cli FLUSHALL


#-----------------------------------------------------------
# Gateway
#-----------------------------------------------------------

# Create shared gateway network
gateway:
	docker network create gateway

# Reload the gateway
gateway\:reload:
	cd ../gateway; make reload

# Update containers and reload the gateway service
update\:reload: build\:all up gateway\:reload


#-----------------------------------------------------------
# Swarm
#-----------------------------------------------------------

# Deploy the stack
swarm\:deploy:
	docker stack deploy --compose-file docker-compose.yml api

# Remove/stop the stack
swarm\:rm:
	docker stack rm api

# List of stack services
swarm\:services:
	docker stack services api

# List the tasks in the stack
swarm\:ps:
	docker stack ps api

# Init the Docker Swarm Leader node
swarm\:init:
	docker swarm init
