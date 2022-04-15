[![Stand With Ukraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner-direct-single.svg)](https://stand-with-ukraine.pp.ua)

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

All laravel logs are forwarded to the docker system using the `stderr` channel.

See the latest logs, running the command:

```bash
docker-compose logs app
```

#### Storage

To use the `public` disk of the Laravel storage system you need to create a symlink.

The symlink should be relative to work properly inside the docker environment.

First, you need to install `symfony/filesystem` package which allows generating relative symlinks.

```bash
composer require symfony/filesystem --dev
```

Then create the symlink using the command:

```bash
# Make command
make storage:link

# Raw command
docker-compose -f docker-compose.dev.yml exec app php artisan storage:link --relative
```

On production environment it will be created automatically 

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

- [ ] add command to remove framework app (left only docker starter template)
- [ ] add stub for mysql
- [ ] add stub for nuxt 2
- [ ] add stub to switch queue into horizon
- [ ] add stub for php-fpm
- [ ] add root makefile to install both apps and stop/up both apps
- [ ] laravel-echo
- [ ] selenium (laravel dusk)
- [ ] add s3 container, probably minio
- [ ] add github actions for testing
- [ ] add possibility to install composer scripts and app_key from stopped containers (run --rm)
- [ ] set up volume permissions (ro, rw, etc)
- [?] remove redis background saves (provide redis conf similar as nginx conf)
- [ ] add health checks to other containers
- [ ] add env variable to prod git branch and command to update app from git & rebuild (deploy script)
- [ ] set up CI script
- [ ] set up according to: https://phpunit.readthedocs.io/en/9.5/installation.html#recommended-php-configuration
- [ ] xDebug (add separate CLI container because it does not work with Swoole) and .idea configuration
- [ ] php-fpm version
  - probably add public to .dockerignore since it will be handled by nginx (only for php-fpm)
  - set up pm.max_children and other fpm params
  - add nginx gateway for fastcgi proxy
- [ ] prod
  - [ ] https://www.laradocker.com/production/#using-docker-compose
  - [ ] opcache preloading: https://theraloss.com/preloading-laravel-in-php7.4/
  - [ ] add redis password
  - [ ] add script to deploy from 0 (env, build, migrations, etc)
  - [ ] add script to clone fresh dev app (env, composer install, generate key)
  - [ ] add env variable to redis mode (disable background saves)
  - [ ] provide .env API_KEY during first prod installation
  - [ ] add script to update containers (rebuild containers, update env, run migrations and other staff)
  - [ ] add secrets: https://docs.docker.com/engine/swarm/secrets/#use-secrets-in-compose
  - [ ] add possibility to open redis and postgres connections outside of docker network conditionally on runtime (using env variables)
  - [?] remove public/index.php
  - [ ] use last commit hash instead of 'latest' image tag
  - [ ] deploy.sh script using ssh secrets
  - [ ] set up docker logging driver
  - [ ] docker swarm deployment (separate swarm compose file)
    - https://docs.docker.com/engine/swarm/stack-deploy/ 
  - [ ] private registry server (pushing/pulling tags)
    - https://www.digitalocean.com/community/tutorials/how-to-set-up-a-private-docker-registry-on-ubuntu-20-04
    - https://chris-vermeulen.com/laravel-in-kubernetes-part-3/
    - https://www.koyeb.com/tutorials/dockerize-and-deploy-a-laravel-application-to-production

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


# Deploy

## Single host & Docker Compose & Git

The simplest solution to deploy apps on same host is only using Docker Compose and Git.

To do that, you need to use some `proxy` in front of `client` and `api` apps.

There are a lot of solutions you can use, for example few of them:

- Traefik
- https://github.com/NginxProxyManager/nginx-proxy-manager
- https://github.com/nginx-proxy/nginx-proxy
