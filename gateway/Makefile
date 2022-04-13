#-----------------------------------------------------------
# Control
#-----------------------------------------------------------

# Include file with .env variables if exists
-include .env

# Start containers
up:
	docker-compose -f ${COMPOSE_FILE} up -d

# Stop containers
down:
	docker-compose -f ${COMPOSE_FILE} down --remove-orphans

# Build containers
build:
	docker-compose -f ${COMPOSE_FILE} build

# Build and restart containers
update: build up

# Force the update process
update\:force:
	docker-compose -f ${COMPOSE_FILE} up -d --build --force-recreate

# Show list of running containers
ps:
	docker-compose -f ${COMPOSE_FILE} ps

# Restart containers
restart:
	docker-compose -f ${COMPOSE_FILE} restart

# Reboot containers
reboot: down up

# View output from containers
logs:
	docker-compose -f ${COMPOSE_FILE} logs

# Show following logs of each container
fl:
	docker-compose -f ${COMPOSE_FILE} logs -f

# Init variables for development environment
env\:dev:
	cp ./.env.dev ./.env

# Init variables for production environment
env\:prod:
	cp ./.env.prod ./.env

# Reload the Nginx service
reload:
	docker-compose -f ${COMPOSE_FILE} exec reverse-proxy nginx -s reload

# Enter the certbot bash session
certbot:
	docker-compose -f ${COMPOSE_FILE} exec certbot /bin/sh


#-----------------------------------------------------------
# SSL
#-----------------------------------------------------------

# Show the list of registered certificates
ssl\:ls:
	docker-compose -f ${COMPOSE_FILE} run --rm --entrypoint "certbot certificates" certbot

# Generate a 4096-bit DH parameter file
ssl\:dh:
	sudo openssl dhparam -out ./.docker/prod/reverse-proxy/ssl/dhparam.pem 2048

# Issue SSL certificates according to the .env parameters (TODO: rewrite with certbot compose service)
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

# Issue SSL certificates according to the .env parameters (TODO: rewrite with certbot compose service)
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

