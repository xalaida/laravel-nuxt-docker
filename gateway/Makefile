#-----------------------------------------------------------
# Containers
#-----------------------------------------------------------

# Build production containers
build:
	docker-compose build

# Start production containers
up:
	docker-compose up -d

# Stop production containers
down:
	docker-compose down --remove-orphans

# Restart production containers
restart:
	docker-compose restart


#-----------------------------------------------------------
# Swarm
#-----------------------------------------------------------

# Deploy the stack
swarm\:deploy:
	docker stack deploy --compose-file docker-compose.yml gateway

# Remove/stop the stack
swarm\:rm:
	docker stack rm gateway

# List of stack services
swarm\:services:
	docker stack services gateway

# List the tasks in the stack
swarm\:ps:
	docker stack ps gateway
