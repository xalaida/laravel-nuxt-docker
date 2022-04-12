# Include .env variables
include .env

#-----------------------------------------------------------
# App
#-----------------------------------------------------------

# Build and run containers
upgrade:
	docker-compose up -d --build --force-recreate

# Reload the Nginx service
reload:
	docker-compose exec reverse-proxy nginx -s reload

# Build containers
build:
	docker-compose build

# Run containers
up:
	docker-compose up -d

# Stop containers
down:
	docker-compose down --remove-orphans

# Restart containers
restart:
	docker-compose restart

# Show container statuses
ps:
	docker-compose ps

# Show container logs
logs:
	docker-compose logs

# Show container logs with following flag
fl:
	docker-compose logs -f

# Create the gateway network
network:
	docker network create gateway

# Copy development environment variables
dev\:env:
	cp ./.env.dev ./.env

# Copy production environment variables
prod\:env:
	cp ./.env.prod ./.env


#-----------------------------------------------------------
# SSL
#-----------------------------------------------------------

# Show the list of registered certificates
ssl\:ls:
	docker-compose run --rm --entrypoint "certbot certificates" certbot

# Generate a 4096-bit DH parameter file
ssl\:dh:
	sudo openssl dhparam -out ./.docker/prod/reverse-proxy/ssl/dhparam.pem 2048

# Issue SSL certificates according to the .env parameters
ssl:
	docker run \
		--rm \
		--interactive \
		--tty \
		--volume ${CURDIR}/.docker/prod/reverse-proxy/ssl:/etc/letsencrypt:rw \
		--publish 80:80 \
		certbot/certbot \
		certonly \
		--non-interactive \
		--agree-tos \
		--domains ${CERTBOT_DOMAINS} \
		--email ${CERTBOT_EMAIL} \
		--standalone \
		--staging

# Issue SSL certificates according to the .env parameters
ssl\:test:
	docker run \
		--rm \
		--interactive \
		--tty \
		--volume ${CURDIR}/.docker/prod/reverse-proxy/ssl:/etc/letsencrypt:rw \
		--publish 80:80 \
		certbot/certbot \
		certonly \
		--non-interactive \
		--agree-tos \
		--domains ${CERTBOT_DOMAINS} \
		--email ${CERTBOT_EMAIL} \
		--standalone \
		--dry-run


#-----------------------------------------------------------
# Bench
#-----------------------------------------------------------

# Run benchmarking over the gateway (requires Apache Bench tool: apt-get install -y apache2-utils)
bench:
	ab -c 50 -n 5000 http://localhost/


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
