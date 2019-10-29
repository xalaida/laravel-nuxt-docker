#-----------------------------------------------------------
# Docker
#-----------------------------------------------------------

# Wake up docker containers
up:
	docker-compose up -d

# Shut down docker containers
down:
	docker-compose down

# Show status of each container
s:
	docker-compose ps

# Show logs of each container
logs:
	docker-compose logs

# Restart all containers
restart: down up

# Restart node container
restart-node:
	docker-compose restart node

# Build and up docker containers
build:
	docker-compose up -d --build

# Build and up docker containers
rebuild: down build

# Shut down and remove all volumes
remove-volumes:
	docker-compose down --volumes

# Remove all existing networks (usefull if network already exists with the same attributes)
prune-networks:
	docker network prune


#-----------------------------------------------------------
# Logs
#-----------------------------------------------------------

# Clear file-based logs
logs-clear:
	sudo rm docker/nginx/logs/*.log
	sudo rm docker/supervisor/logs/*.log
	sudo rm api/storage/logs/*.log


#-----------------------------------------------------------
# Database
#-----------------------------------------------------------

# Run database migrations
db-migrate:
	docker-compose exec php-cli php artisan migrate

# Run migrations rollback
db-rollback:
	docker-compose exec php-cli php artisan rollback

# Run seeders
db-seed:
	docker-compose exec php-cli php artisan db:seed

# Fresh all migrations
db-fresh:
	docker-compose exec php-cli php artisan migrate:fresh

# Dump database into file
db-dump:
	docker-compose exec postgres pg_dump -U app -d app > docker/postgres/dumps/dump.sql


#-----------------------------------------------------------
# Redis
#-----------------------------------------------------------

redis:
	docker-compose exec redis redis-cli

redis-flush:
	docker-compose exec redis redis-cli FLUSHALL

redis-install:
	docker-compose exec php-cli composer require predis/predis


#-----------------------------------------------------------
# Queue
#-----------------------------------------------------------

# Restart queue process
queue-restart:
	docker-compose exec php-cli php artisan queue:restart


#-----------------------------------------------------------
# Testing
#-----------------------------------------------------------

# Run phpunit tests
test:
	docker-compose exec php-cli vendor/bin/phpunit

# Run phpunit tests with coverage
coverage:
	docker-compose exec php-cli vendor/bin/phpunit --coverage-html tests/report


#-----------------------------------------------------------
# Dependencies
#-----------------------------------------------------------

composer-install:
	docker-compose exec php-cli composer install

composer-update:
	docker-compose exec php-cli composer install

yarn-update:
	docker-compose exec node-cli yarn update

dependencies-update: composer-update yarn-update


#-----------------------------------------------------------
# Tinker
#-----------------------------------------------------------

# Run tinker
tinker:
	docker-compose exec php-cli php artisan tinker


#-----------------------------------------------------------
# Installation
#-----------------------------------------------------------

# Copy the environment file
env:
	cp .env app/.env

# Add permissions for Laravel cache and storage folders
permissions:
	sudo chmod -R 777 api/bootstrap/cache
	sudo chmod -R 777 api/storage

# Generate a Laravel app key
key:
	docker-compose exec php-cli php artisan key:generate --ansi

# PHP composer autoload comand
autoload:
	docker-compose exec php-cli composer dump-autoload

# Install the environment
install: build composer-install env key permissions
