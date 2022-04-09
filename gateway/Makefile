#-----------------------------------------------------------
# Production
#-----------------------------------------------------------

# Build production containers
prod\:build:
	docker-compose -f docker-compose.prod.yml build

# Start production containers
prod\:up:
	docker-compose -f docker-compose.prod.yml up -d

# Stop production containers
prod\:down:
	docker-compose -f docker-compose.prod.yml down --remove-orphans


#-----------------------------------------------------------
# Swarm
#-----------------------------------------------------------

# Deploy the stack
prod\:swarm\:deploy:
	docker stack deploy --compose-file docker-compose.prod.yml gateway

# Remove/stop the stack
prod\:swarm\:rm:
	docker stack rm gateway

# List of stack services
prod\:swarm\:services:
	docker stack services gateway

# List the tasks in the stack
prod\:swarm\:ps:
	docker stack ps gateway

# Init the Docker Swarm Leader node
prod\:swarm\:init:
	docker swarm init
