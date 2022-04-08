# Dockerized template for your next Laravel and Nuxt project

Well tested on Ubuntu 18.04, 19.10 and 20.04.

## Stack includes

* API
  * Laravel (latest version)
  * Octane
  * PostgreSQL 13 (and separate database for testing)
  * Redis 6
  * MailHog
* Client
  * Nuxt 3 (latest version)

## Description

The following image demonstrates a request path going through the environment.

![Schema](schema.drawio.png)

Laravel API and Nuxt are totally separate from each other and there are some reasons why I don't mix them up.
- First, throwing two frameworks together is a guaranteed mess in the future.
- API should be the only one layer of coupling.
- You can host them on the different servers.
- You can even split them into separate repositories if (when) the project will grow.
- You can even add a third project, for example, a mobile app (or a separate Nuxt app for admin panel, for example), which will use the same API as well.

## Getting Started

Clone or download the repository and enter its directory:

```bash
git clone https://github.com/nevadskiy/laravel-nuxt-docker.git app
cd app
```

Then, install both API and client apps.

## API

Your Laravel app will be placed in the `/api` directory.

### Installation

First, you need to create shared network, build API containers and init a new Laravel app. 

To do it, execute the `install.sh` script:

```bash
cd api
./install.sh
```

It will install a Laravel app along with [Octane](https://laravel.com/docs/octane) package and [Breeze](https://laravel.com/docs/starter-kits#breeze-and-next) API scaffolding.

Now you can start the API app.

### Usage

#### Start

To start containers, run the command:

```bash
# Make command
make up

# Raw command
docker-compose up -d
```

Now you can open [http://localhost:8000](http://localhost:8000) URL in your browser.

#### Stop

To stop containers, run the command:

```bash
# Make command
make down

# Raw command
docker-compose down
```

#### Makefile commands

There are a lot of useful **make** commands in the [Makefile](./api/Makefile), that will make your development process much easier.

For example, to migrate the database execute the command:

```bash
make migrate
```

Feel free to explore it and edit according to your needs.

#### Bash aliases

Also, there is a set of bash aliases which you can apply using the command:

```bash
source aliases.sh
```

Now to run any artisan command you can use:

```bash
artisan make:model Product
```

#### Logs

All laravel logs are forwarded to the docker system using the `stdout` channel.

See the latest logs, running the command:

```bash
docker-compose logs app
```

#### Storage

To use Laravel storage with a local disk, create a symlink using the command:

```bash
# Make command
make storage

# Raw command
docker-compose exec app php artisan storage:link --relative
```

#### MailHog

If you want to check how sent mails look, just go to [http://localhost:8026](http://localhost:8026).

[MailHog](https://github.com/mailhog/mailhog) is an email testing tool for developers.

## Client

Your Nuxt app will be placed in the `/client` directory.

## Installation

To build and install a new Nuxt app, execute the `install.sh` script:

```bash
cd client
./install.sh
```

### Usage

#### Start

To start containers, run the command:

```bash
# Make command
make up

# Raw command
docker-compose up -d
```

Now, you can open [http://localhost:3000](http://localhost:3000) URL in your browser.

#### Stop

To stop containers, run the command:

```bash
# Make command
make down

# Raw command
docker-compose down
```

#### Fetch API data

To fetch data from the Laravel API, you have to use different endpoints when requesting data from the browser and during the SSR process from the Node server instance.

The `.env` file already contains those endpoints, so you can use the following `nuxt.config.ts` file:

```ts
import { defineNuxtConfig } from 'nuxt3'

export default defineNuxtConfig({
  publicRuntimeConfig: {
    apiUrlBrowser: process.env.API_URL_BROWSER,
  },

  privateRuntimeConfig: {
    apiUrlServer: process.env.API_URL_SERVER,
  }
})
```

Then, you can create something like this composable function `/composables/apiFetch.ts`:

```ts
import type { FetchOptions } from 'ohmyfetch'

export const useApiFetch = (path: string, opts?: FetchOptions) => {
  const config = useRuntimeConfig()

  return $fetch(path, {
    baseURL: process.server ? config.apiUrlServer : config.apiUrlBrowser,
    ...(opts && { ...opts })
  })
}
```

Now in the component file you can use it as following:

```vue
<script setup>
const { data } = await useApiFetch('/products')
</script>
```

## To Do list:

- [ ] add stub for mysql
- [ ] add stub for nuxt 2
- [ ] add stub to switch queue into horizon
- [ ] add stub for php-fpm
- [ ] add root makefile to install both apps and stop/up both apps
- [ ] laravel-echo
- [ ] selenium (laravel dusk)
- [ ] add s3 container, probably minio
- [ ] add github actions for testing
- [ ] set up volume permissions (ro, rw, etc)
- [?] remove redis background saves (provide redis conf similar as nginx conf)
- [ ] share `php.ini` between all api php-related containers
- [ ] add health checks to other containers
- [ ] remove .sh extension from bash scripts
- [ ] fix queue stop signal: https://stackoverflow.com/a/63851444/8041541
- [ ] xDebug (only for CLI, not supported with Swoole) and .idea configuration
- [ ] prod
  - [ ] https://www.laradocker.com/production/#using-docker-compose
  - [ ] proxy gateway
  - [ ] certbot
  - [ ] separate .env variables for prod build
  - [ ] private registry server
  - [ ] pushing/pulling tags
    - [ ] https://chris-vermeulen.com/laravel-in-kubernetes-part-3/
    - [ ] https://www.koyeb.com/tutorials/dockerize-and-deploy-a-laravel-application-to-production
  - [ ] http2, brotli/gzip, ssl config
  - [ ] handling static files
  - [ ] opcache + jit
  - [ ] add .dockerignore
  - [ ] provide .env API_KEY during first prod installation 
  - [ ] add secrets: https://docs.docker.com/engine/swarm/secrets/#use-secrets-in-compose
  - [ ] volume storage 
  - [ ] add possibility to open redis and postgres connections outside of docker network conditionally on runtime (using env variables)
  - [ ] add stats command: https://docs.docker.com/config/containers/runmetrics/
  - [?] remove public/index.php
  - [ ] configure proper timeouts to handle big traffic
  - [ ] allow custom ssl certs (provide volume or directory for them)
  - [ ] use last commit hash instead of 'latest' image tag
  - [ ] registry server: https://www.digitalocean.com/community/tutorials/how-to-set-up-a-private-docker-registry-on-ubuntu-20-04
  - [ ] docker swarm deployment
  - [ ] .git deployment
  - [ ] deploy.sh script
  - [ ] grafana vs prometheus monitoring tool (and forward logs into it)

##### Init laravel from sail

```bash
docker run --rm -it \
  -u "$(id -u)":"$(id -g)" \
  -v "$(pwd)":/var/www/html \
  -w /var/www/html \
  laravelsail/php81-composer:latest \
  composer create-project --prefer-dist laravel/laravel src
```

##### Install sail package

```bash
docker run --rm -it \
  -u "$(id -u)":"$(id -g)" \
  -v "$(pwd)":/var/www/html \
  -w /var/www/html/src \
  laravelsail/php81-composer:latest \
  php artisan sail:install
```
