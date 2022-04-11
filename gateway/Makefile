#-----------------------------------------------------------
# SSL
#-----------------------------------------------------------

# Generate a 4096-bit DH parameter file
dhparam:
	sudo openssl dhparam -out ./.docker/prod/reverse-proxy/ssl/dhparam.pem 2048


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

# Show status of each container
ps:
	docker-compose ps

# Show logs of each container
logs:
	docker-compose logs


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


#-----------------------------------------------------------
# Bench
#-----------------------------------------------------------

# Run benchmarking over the gateway (requires Apache Bench tool: apt-get install -y apache2-utils)
bench:
	ab -c 50 -n 5000 http://localhost/
