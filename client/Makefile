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

# Build containers
build:
	docker-compose build

# Build containers without cache
rebuild:
	docker-compose build --no-cache
