# Start containers
up:
	docker-compose up -d

# Stop containers
down:
	docker-compose down --remove-orphans

# Build containers
build:
	docker-compose build

# Build and restart containers
update: build up

# Show list of running containers
ps:
	docker-compose ps

# Restart containers
restart:
	docker-compose restart

# Reboot containers
reboot: down up
