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

##---------------------------
## Application
##---------------------------
#
#migrate:
#	docker-compose exec php-cli php artisan migrate
#
#rollback:
#	docker-compose exec php-cli php artisan rollback
#
#refresh:
#	docker-compose exec php-cli php artisan migrate:fresh
#
#seed:
#	docker-compose exec php-cli php artisan db:seed -v
#
#reseed: refresh seed
#
#tinker:
#	docker-compose exec php-cli php artisan tinker
#
#test:
#	docker-compose exec php-cli vendor/bin/phpunit
#
#coverage:
#	docker-compose exec php-cli vendor/bin/phpunit --coverage-html tests/report
#
#autoload:
#	docker-compose exec php-cli composer dump-autoload
#
#perm:
#	sudo chmod -R 777 bootstrap/cache
#	sudo chmod -R 777 storage
#
#env:
#	cp ./.env.example ./.env
#	docker-compose exec php-cli php artisan key:generate
#
##---------------------------
## Front-end
##---------------------------
#
#assets:
#	docker-compose exec node yarn install
#
#watch:
#	docker-compose exec node yarn watch