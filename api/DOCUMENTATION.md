# API

This is where your Laravel application is stored.

## Stack includes

* Laravel (latest version)
* Octane
* PostgreSQL (and separate database for testing)
* Redis
* MailHog

## Installation

The whole installation process is to create a shared network, build containers and initialize a new Laravel application.

Run the installation script in your terminal, and it will do it all automatically:

```bash
./install.sh
```

Also, it will install a Laravel app along with [Octane](https://laravel.com/docs/octane) package and [Breeze](https://laravel.com/docs/starter-kits#breeze-and-next) API scaffolding.

Now you should be able to see it running in your browser at [http://localhost:8000](http://localhost:8000).

## Usage

All docker commands are abstracted into [Makefile](./Makefile) instructions.

They are very simple and often just instead of the `docker-compose` command you need to write `make` in your terminal.

Of course, you can still use the `docker-compose` commands in the terminal, but you should remember that development and production environments rely on different docker-compose files. 

Example:
```
# Make command
make up

# Full command
docker-compose -f docker-compose.dev.yml up -d
```

Because *make* commands are much easier to use than full docker-compose commands, I prefer and recommend using them, so free to explore them and edit according to your needs.

### Start containers

```bash
# Make command
make up

# Full command
docker-compose -f docker-compose.dev.yml up -d
```

Now you can open [http://localhost:8000](http://localhost:8000) URL in your browser.

### Stop containers

```bash
# Make command
make down

# Full command
docker-compose -f docker-compose.dev.yml down
```

### Bash aliases

Also, there is a set of [bash aliases](./aliases.sh) which you can apply using the command:

```bash
source aliases.sh
```

Now to run any artisan command you can use:

```bash
artisan make:model Product
```

### Logs

All laravel logs are forwarded to the docker log collector via the `stderr` channel.

See the latest logs, running the command:

```bash
docker-compose logs app
```

### Storage

To use the `public` disk of the Laravel storage system you need to create a symlink.

The symlink should be relative to work properly inside the docker environment and outside it at the same time.

First, you need to install `symfony/filesystem` package which allows generating relative symlinks.

```bash
docker-compose -f docker-compose.dev.yml exec app composer require symfony/filesystem --dev
```

Then create the symlink using the command:

```bash
# Make command
make storage:link

# Raw command
docker-compose -f docker-compose.dev.yml exec app php artisan storage:link --relative
```

On production environment it will be created automatically.

### Mailing

The [MailHog](https://github.com/mailhog/mailhog) service intercepts all sent emails by your application in development environment.

If you want to check how sent mails look, just go to [http://localhost:8026](http://localhost:8026).

## Alternatives

The best alternative to this is the official [Laravel Sail](https://laravel.com/docs/9.x/sail) tool which is intended for development environment only.

Sail is automatically installed with all new Laravel applications. 

If you do not have locally installed PHP or Composer but have `docker`, you can use the following commands: 

```bash
# Install a new Laravel application
docker run --rm -it \
  -u "$(id -u)":"$(id -g)" \
  -v "$(pwd)":/var/www/html \
  -w /var/www/html \
  laravelsail/php81-composer:latest \
  composer create-project --prefer-dist laravel/laravel src
  
# Configure the Sail environment 
docker run --rm -it \
  -u "$(id -u)":"$(id -g)" \
  -v "$(pwd)":/var/www/html \
  -w /var/www/html/src \
  laravelsail/php81-composer:latest \
  php artisan sail:install
```

## To Do list

- [ ] refactor dockerfile clean up and run instructions according to this: https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#run

- [ ] git dev pull script (when pulling existing app)
  - pull git branch
  - replace old .env file with a new one
  - build containers
  - composer install
  - generate api key
  - up containers (queue and octane should be restarted)
  - run migrations
  - seed database

- [ ] git prod deploy script (can be called by ssh with secrets)
  - pull git branch
  - ensure env file is up-to-date (probably add git-ignored .env.prod.secrets (similar to docker swarm) to merge with .env.prod file)
  - build containers
  - composer install
  - generate api key
  - up containers (queue and octane should be restarted)
  - run migrations (--force)

- [ ] add stubs system (to provide/replace additional services)
- [ ] add stub for mysql
- [ ] add stub for laravel-echo
- [ ] add stub for s3 container, probably minio (for stateless app)
- [ ] add stub for selenium (laravel dusk)
- [ ] add stub to replace default queue runner with horizon
- [ ] add stub for CLI container with installed xDebug (because xDebug conflicts Swoole)
- [ ] add health checks to other containers
- [ ] set up volume permissions (ro, rw, etc)
- [ ] set up according to: https://phpunit.readthedocs.io/en/9.5/installation.html#recommended-php-configuration
- [ ] add bash `azov` app to manage api containers (instead of current aliases file)
- [ ] php-fpm version
  - probably add public to .dockerignore since it will be handled by nginx (only for php-fpm)
  - set up pm.max_children and other fpm params
  - add nginx gateway for fastcgi proxy

- [ ] configure redis
  - add redis password
  - remove redis background saves
  - provide redis conf similar as nginx conf

- [ ] simple git and docker-compose deployment
  - [ ] add secrets (from 3.9 version): https://docs.docker.com/engine/swarm/secrets/#use-secrets-in-compose
  - [ ] add possibility to open redis and postgres connections (by publishing ports) outside of docker network conditionally on runtime (using env variables)
  - [ ] set up docker logging driver
  - [ ] opcache preloading: https://theraloss.com/preloading-laravel-in-php7.4/
  - [ ] think about using last commit hash instead of 'latest' image tag

- [ ] swarm deployment (separate docker-compose.swarm.yml)
  - https://docs.docker.com/engine/swarm/stack-deploy/
  - [ ] set up private registry server (pushing/pulling tags)
    - https://www.digitalocean.com/community/tutorials/how-to-set-up-a-private-docker-registry-on-ubuntu-20-04
    - https://chris-vermeulen.com/laravel-in-kubernetes-part-3/
    - https://www.koyeb.com/tutorials/dockerize-and-deploy-a-laravel-application-to-production
