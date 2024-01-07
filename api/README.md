# API

This directory houses your Laravel application.

## Stack

* Laravel + Octane
* PostgreSQL
* Redis
* Mailpit (SMTP server)
* Minio (S3 compatible server)

## Installation

The installation process involves creating a shared network, building images, and initializing a new Laravel application. Execute the following script in your terminal to automate the entire process:

```bash
./install.sh
```

This script installs a Laravel app along with [Octane](https://laravel.com/docs/octane) and [S3](https://laravel.com/docs/10.x/filesystem#s3-driver-configuration) packages.

Now you should be able to see it running in your browser at [http://localhost:8000](http://localhost:8000).

## Environments

There are own docker compose file for each environment: production, local, and testing. For local development it could be useful to rename a `compose.local.yaml` file to `compose.yaml`. This allows to run docker compose command  without having to specify the specific compose file.

### Building images

For example, to build images for local environment, use the following command:

```bash
docker compose -f compose.local.yaml build
```

### Start containers

```bash
docker compose -f compose.local.yaml up
```

Now you can open [http://localhost:8000](http://localhost:8000) URL in your browser.

### Stop containers

```bash
docker compose -f compose.local.yaml down
```

### Artisan commands

For artisan commands, specify the current user to ensure correct file permissions. For example, to generate a `Product` model:

```bash
docker compose -f compose.local.yaml exec --user $(id -u):$(id -g) app php artisan make:model Product
```

### Mails

The [Mailpit](https://github.com/axllent/mailpit) service intercepts all sent emails by your application in the local environment.

If you want to check how sent mails look, just go to [http://localhost:8025](http://localhost:8025) in your browser.

### Testing

Use `compose.testing.yaml` for testing. This environment is simpler than the local setup as it doesn't require a separate web server, queue worker, allowing us to use drivers like "sync" for the queue and "array" for the cache.

It features a separate database with an in-memory volume for improved performance during database-dependent tests.

Start the testing environment with:

```bash
docker compose -f compose.testing.yaml up -d
```

Then we can execute tests really quick like this:

```bash
docker compose -f compose.testing.yaml exec app vendor/bin/phpunit
```

For convenience create a useful bash alias like this:

```bash
alias t="docker compose -f compose.testing.yaml exec app vendor/bin/phpunit"
```

Then you can run tests by simply using these commands:

```bash
# Run all tests
t

# Run tests with filter by "ProductTest"
t --filter ProductTest

# Run tests from Unit suite
t --testsuite Unit
```

### Logs

All laravel logs are forwarded to the docker log collector via the `stderr` channel.

See the latest logs running the command:

```bash
docker compose -f compose.local.yaml logs
```

## Alternatives

### Laravel Sail

The best alternative to this is the official [Laravel Sail](https://laravel.com/docs/sail) tool which is intended for development environment only.

Sail is automatically installed with all new Laravel applications.

### Laradock

Also, there is an excellent project called [Laradock](https://laradock.io/) that contains a full bunch of services.

## To Do List

- [ ] use php.ini-development & php.ini-production from base php image
- [ ] replace octane watcher with `docker compose watch` for app, queue, schedule services
