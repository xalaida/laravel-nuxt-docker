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
	docker-compose logs --tail=500

# Show following logs of each container
fl:
	docker-compose logs -f --tail=500


#-----------------------------------------------------------
# App
#-----------------------------------------------------------

# Enter into the app container
app:
	docker-compose exec app bash

# Run the tinker service
tinker:
	docker-compose exec app php artisan tinker

# Clear the app cache
cache\:clear:
	docker-compose exec app php artisan cache:clear

# Migrate the database
db\:migrate:
	docker-compose exec app php artisan migrate

# Alias to migrate the database
migrate: db\:migrate

# Rollback the database
db\:rollback:
	docker-compose exec app php artisan migrate:rollback

# Seed the database
db\:seed:
	docker-compose exec app php artisan db:seed

# Migrate the database wi
db\:fresh:
	docker-compose exec app php artisan migrate:fresh

# Dump database into file
db\:dump:
	docker-compose exec postgres pg_dump -U ${DB_USERNAME} -d ${DB_DATABASE} > ./.docker/postgres/dumps/dump.sql

# Restart the queue process
queue\:restart:
	docker-compose exec app php artisan queue:restart

# Generate the app key
key:
	docker-compose exec app php artisan key:generate --ansi

# Generate a symlink to the storage directory
storage:
	docker-compose exec app php artisan storage:link --relative


#-----------------------------------------------------------
# Testing
#-----------------------------------------------------------

# Run phpunit tests
test:
	docker-compose exec app ./vendor/bin/phpunit --order-by=defects --stop-on-defect

# Alias to run phpunit tests
t: test

# Run phpunit tests with coverage
coverage:
	docker-compose exec app ./vendor/bin/phpunit --coverage-html ./.coverage

# Run dusk tests
dusk:
	docker-compose exec app php artisan dusk

# Generate metrics
metrics:
	docker-compose exec app ./vendor/bin/phpmetrics --report-html=./.metrics api/app


#-----------------------------------------------------------
# Dependencies
#-----------------------------------------------------------

# Install composer dependencies
composer\:install:
	docker-compose exec app composer install

# Alias to install composer dependencies
ci: composer\:install

# Update composer dependencies
composer\:update:
	docker-compose exec app composer update

# Alias to update composer dependencies
cu: composer\:update

# Show outdated composer dependencies
composer\:outdated:
	docker-compose exec app yarn outdated

# PHP composer autoload command
composer\:autoload:
	docker-compose exec app composer dump-autoload


#-----------------------------------------------------------
# Redis
#-----------------------------------------------------------

# Enter into the redis container
redis:
	docker-compose exec redis redis-cli

# Flush the redis state
redis-flush:
	docker-compose exec redis redis-cli FLUSHALL


#-----------------------------------------------------------
# Installation
#-----------------------------------------------------------

# Create shared API network
network:
	docker network create api

# Build containers
build: build-base
	docker-compose build

# Build the base app image
build-base:
	docker build ./.docker/dev/base -t api-base

# Build containers without cache
rebuild:
	docker-compose build --no-cache

# Set up permissions for cache and storage folders
permissions:
	sudo chmod -R 777 bootstrap/cache
	sudo chmod -R 777 storage
