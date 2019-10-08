#-----------------------------------------------------------
# Docker controls
#-----------------------------------------------------------

# Up docker containers
up:
	docker-compose up -d

# Shut down docker containers
down:
	docker-compose down

# Show status of the each container
s:
	docker-compose ps

# Show status of the each container
logs:
	docker-compose logs

# Restart all docker containers
restart: down up

# Restart all docker containers
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

# Show status of the each container
clear-logs:
	sudo rm docker/nginx/logs/access.log
	sudo rm docker/nginx/logs/error.log
	sudo rm docker/supervisor/logs/cron.log
	sudo rm docker/supervisor/logs/queue.log

# Remove all existing networks (usefull if network already exists with the same attributes)
prune-networks:
	docker network prune


#-----------------------------------------------------------
# Laravel
#-----------------------------------------------------------

# Add permissions for cache and store folders
permissions:
	sudo chmod -R 777 api/bootstrap/cache
	sudo chmod -R 777 api/storage

# Run tinker
tinker:
	docker-compose exec php-cli php artisan tinker

# Run phpunit tests
test:
	docker-compose exec php-cli vendor/bin/phpunit

# Run phpunit tests with coverage
coverage:
	docker-compose exec php-cli vendor/bin/phpunit --coverage-html tests/report

# PHP composer autoload comand
autoload:
	docker-compose exec php-cli composer dump-autoload

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

# Fresh all migrations
key:
	docker-compose exec php-cli php artisan key:generate --ansi


#-----------------------------------------------------------
# Database
#-----------------------------------------------------------

# Dump database into file
db-dump:
	docker-compose exec postgres pg_dump -U app -d app > docker/postgres/dumps/dump.sql


#-----------------------------------------------------------
# Dependencies
#-----------------------------------------------------------

composer-install:
		docker-compose exec php-cli composer install

dependencies-update:
		docker-compose exec php-cli composer update
		docker-compose exec node-cli yarn update
