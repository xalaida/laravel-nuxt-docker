## About
Dockerized started template for Laravel + Nuxt.JS project.

## Available containers
* Nginx (as proxy resolver between Laravel and Nuxt)
* PHP-FPM version 7.3
* Node version 12.4 (For SSR)
* Redis
* PostgreSQL version 11.3
* Supervisor with queue and schedule
* Mailhog for easy SMTP testing
* NODE-CLI for front-end workspace
* PHP-CLI for back-end workspace

## Installation

**1. Download or clone repo**
```
git clone https://github.com/nevadskiy/laravel-nuxt-docker.git app
```

**2. Run the command:**
```
docker-compose up -d --build
```
Or the same with available _make_ command
```
make build
```

_It lasts about 10 minutes, so you can take a coffee break_

**3. Install composer dependencies:**
```
docker-compose exec php-cli composer istall
```
Or the same with available _make_ command
```
make composer-install
```

**4. Copy environment file**
```
cp .env api/.env
```
Or the same with available _make_ command
```
make composer-install
```

**5. Set up laravel permissions**
```
	sudo chmod -R 777 api/bootstrap/cache
	sudo chmod -R 777 api/storage
```
Or the same with available _make_ command
```
make permissions
```

**6. That's it. Go to http://localhost:8080 and start to develop.**
 
_If you see 502 error, just wait a bit when _yarn install_ process will be finished (Check the status with the command ```docker-compose logs node```)_

## Usage

To up all containers, run
```
docker-compose up -d
```
Or the same with available _make_ command
```
make up
```

**Nuxt**

Application is available by http://localhost:8080 url (you also can change it in your _/etc/hosts_ file).

If you want to use **_Axios_** module, set 8080 port in its configuration (nuxt.config.js)
```
  /*
   ** Axios module configuration
   ** See https://axios.nuxtjs.org/options
   */
  axios: {
    port: 8080
  }, 
```

**Laravel**

Laravel API is available with http://localhost:8080/api url (or http://localhost:8081)

Artisan commands can be used like this:
```
docker-compose exec php-cli php artisan migrate
```
If you want to generate a new controller, the commands should be executed from the current user like this:
```
docker-compose exec --user "$(id -u):$(id -g)" php-cli php artisan make:controller HomeController
```
To make the workflow a simpler, there is the aliases.sh file, which allow to do the same like this:
```
artisan make:controller HomeController
```
[More about aliases.sh](#Aliases)

**Database**

If you want to connect to PostgreSQL database from external tool, for example _Sequel Pro_ or _Navicat_, use the following parameters:
```
HOST: localhost
PORT: 54321
DB: app
USER: app
PASSWORD: app   
```

Also you can connect to DB with CLI using docker container:
```
// Connect to container bash cli
docker-compose exec postgres bash
    // Then connect to DB cli 
    psql -U ${POSTGRES_USER} -d ${POSTGRES_DB}
```

For example, if you want to export dump file, use the command:
```
docker-compose exec postgres pg_dump ${POSTGRES_USER} -d ${POSTGRES_DB} > docker/postgres/dumps/dump.sql
```
For import file into database, put your file to docker/postgres/dumps folder, it mounts into /tmp folder inside container:
```
// Connect to container bash cli
docker-compose exec postgres bash
    // Then connect to DB cli 
    psql -U ${POSTGRES_USER} -d ${POSTGRES_DB} < /tmp/dump.sql
```

**Redis**

To connect to redis cli, use the command:
```
docker-compose exec redis redis-cli
```

If you want to connect with external GUI tool, use the port 54321

**Mailhog**
If you want to check how all sent mail look, just go to http://localhost:8026.
It is test mail catcher tool for SMTP testing.

For using Laravel api from Nuxt.JS application, you must add **_/api_** prefix for all API requests.

### Logs

All **_nginx_** logs are available inside _docker/nginx/logs_ directory

All **_supervisor_** logs are available inside _docker/supervisor/logs_ directory

To view docker containers logs, use the commands:
```
docker-compose logs
docker-compose logs <container>
```

#### Makefile
For example, to start all docker containers you may use:
```
make up
```

Feel free to explore it, there are some useful commands for comfortable development.

#### Aliases
Also, there are _aliases.sh_ file which you can apply with command:
```
source aliases.sh
```
For example, it helps to execute commands from containers a little simpler:

Instead of
```
docker-compose exec php-cli artisan migate
```
Now available 'from' alias
```
from php-cli artisan migate
```

**If you want to reinstall laravel from scratch with the fresh version, use the following commands:**

Remove the old laravel directory and create the new empty one
```
sudo rm -rf api
mkdir api
```

Restart docker containers to allow to remount the new just created 'api' directory
```
docker-compose restart
```

Install laravel inside the container working directory (our just created api directory on the previous step)
```
docker-compose exec php-cli composer create-project --prefer-dist laravel/laravel .
```

Give permissions for all files and directories generated by docker user to current user
```
sudo chown ${USER}:${USER} -R api
```

Set up laravel permissions
```
sudo chmod -R 777 api/bootstrap/cache
sudo chmod -R 777 api/storage
```

Update environment variables and generate laravel application key
```
sudo rm api/.env
cp .env api/.env
docker-compose exec php-cli php artisan key:generate 
```

Install redis php client
```
docker-compose exec php-cli composer require predis/predis
```

Open http://localhost:8081 and make sure it works

**If you want to reinstall Nuxt.JS from scratch with the fresh version, use the following commands:**

Remove the old nuxt directory and create the new one
```
sudo rm -rf client
mkdir client
```

Restart docker containers to allow to remount the new just created 'client' directory
```
docker-compose restart
```

Create the new nuxt project with preferable configurations (no custom server framework, universal rendering mode, yarn package manager)
```
docker-compose exec node-cli yarn create nuxt-app .
```

Give permissions for all files and directories generated by docker user to current user
```
sudo chown ${USER}:${USER} -R client
```

Restart docker containers again for executing fresh nuxt instance
```
docker-compose restart
```

Open http://localhost:8080 and make sure it works


##### TODO LIST:
- add image to readme.md with connected containers and workflow explaining 
- add xDebug phpstorm tutorial
- add other containers (selenium, laravel-echo-server)
- add instructions about testing (and generate .env.testing file)
- migrate to SSL and probably HTTP2
- find and replace all hardcoded values with ENV variables 
