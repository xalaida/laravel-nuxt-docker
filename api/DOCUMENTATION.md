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

If you want to check how sent mails look, just go to [http://localhost:8025](http://localhost:8025).

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

Also, there is an excellent project called [Laradock](https://laradock.io/) that contains a full bunch of services.
