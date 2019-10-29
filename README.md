## About
Dockerized starter template for Laravel + Nuxt.JS project.

## Stack includes
* Laravel (clean 6.4 version)
* Nuxt.JS (clean 2.10 version)
* PostgreSQL 11.3
* Redis 3.0
* Mailhog (SMPT testing)
* Nginx
* Supervisor (queues, schedule commands, etc.)

#### Also
* Bash aliases for simple cli using
* A lot of useful **make** commands
* The separate testing database

## Installation

**1. Clone or download the repository and enter its folder**
```
git clone https://github.com/nevadskiy/laravel-nuxt-docker.git app
cd app
```

**2. Run the installation script (it may take up to 10 minutes)**
```
make install
```

**3. That's it.** 

Open [http://localhost:8080](http://localhost:8080) url in your browser.

There is also available [http://localhost:8081](http://localhost:8081) which is handled by Laravel and can be used for comfortable testing. 

_If you see 502 error, just wait a bit when ```yarn install && yarn dev``` process will be finished (Check the status with the command ```docker-compose logs node```)_

### Manual installation
If you do not have available the make utility or you just want to install the project manually, you can go through the installation process running the following commands:

**Build and up docker containers (It may take up to 10 minutes)**
```
docker-compose up -d --build
```

**Install composer dependencies:**
```
docker-compose exec php-cli composer istall
```

**Copy the environment file**
```
cp .env api/.env
```

**Set up laravel permissions**
```
sudo chmod -R 777 api/bootstrap/cache
sudo chmod -R 777 api/storage
```

## Usage

Your base url is ```http://localhost:8080```. All requests to Laravel API should be sent at the url which starts from ```http://localhost:8080/api```. Nginx server will proxy all requests the with ```/api``` prefix to the node server which serves the nuxt. 

**Environment**

To up all containers, run the command:
```
# Full command
docker-compose up -d

# Make command
make up
```

To shut down all containers, run the command:
```
# Full command
docker-compose down

# Make command
make down
```

**Nuxt**

Your application is available at the [http://localhost:8080](http://localhost:8080) url.

If you want to use **_Axios_** module, set ```8080``` port in the nuxt configuration file (nuxt.config.js).
```
  /*
   ** Axios module configuration
   ** See https://axios.nuxtjs.org/options
   */
  axios: {
    port: 8080
  }, 
```

If you update or install node dependencies, then you should restart the nuxt process which is run by node container like this:
```
docker-compose restart node
```

**Laravel**

Laravel API is available at the [http://localhost:8080/api](http://localhost:8080/api) url. For testing purposes you can also use the ```[http://localhost:8081](http://localhost:8081)``` url, which Nginx will proxy directly to the Laravel. 

Artisan commands can be used like this:
```
docker-compose exec php-cli php artisan migrate
```

But if you want to generate a new controller or any laravel class, all commands should be executed from the current user like this, which grants all needed file permissions
```
docker-compose exec --user "$(id -u):$(id -g)" php-cli php artisan make:controller HomeController
```

To make the workflow simpler, there is the _aliases.sh_ file, which allow to do the same work like this
```
artisan make:controller HomeController
```
[More about aliases.sh](#Aliases)

#### Makefile
There are a lot of useful make commands you can use. 
All of them you should run from the project directory where Makefile is located.

Examples:
```
# Up docker containers
make up

# Apply the migrations
make db-migrate

# Run tests
make test

# Down docker containers
make down
```

Feel free to explore it and add your commands if you need them.

#### Aliases
Also, there is _aliases.sh_ file which you can apply with command:
```
source aliases.sh
```
_Note that you should always run this command when you open the terminal._

It helps to execute commands from different containers a bit simpler:

For example, instead of
```
docker-compose exec postgres pg_dump
```
You can use the alias
```
from postgres pg_dump
```

But the big power is *artisan* alias:

If you want to generate a new controller or any Laravel class, all commands should be executed from the current user, which grants all needed file permissions
```
docker-compose exec --user "$(id -u):$(id -g)" php-cli php artisan make:model Post
```

The artisan alias allows to do the same like this:
```
artisan make:model Post
``` 


**Database**

If you want to connect to PostgreSQL database from external tool, for example _Sequel Pro_ or _Navicat_, use the following parameters
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

For example, if you want to export dump file, use the command
```
docker-compose exec postgres pg_dump ${POSTGRES_USER} -d ${POSTGRES_DB} > docker/postgres/dumps/dump.sql
```

To import file into database, put your file to docker/postgres/dumps folder, it mounts into /tmp folder inside container
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

If you want to connect with external GUI tool, use the port ```54321```

**Mailhog**
If you want to check how all sent mail look, just go to [http://localhost:8026](http://localhost:8026).
It is the test mail catcher tool for SMTP testing. All sent mails will be stored here..

### Logs

All **_nginx_** logs are available inside the _docker/nginx/logs_ directory

All **_supervisor_** logs are available inside the _docker/supervisor/logs_ directory

To view docker containers logs, use the commands:
```
# All containers
docker-compose logs

# Concrete container
docker-compose logs <container>
```

#### Reinstallation

**If you want to reinstall Laravel from scratch with a fresh version, use the following commands:**

Remove the old Laravel directory and create a new empty one
```
sudo rm -rf api
mkdir api
```

Restart docker containers to allow to remount the ```api``` directory
```
docker-compose restart
```

Create a new Laravel project 
```
docker-compose exec php-cli composer create-project --prefer-dist laravel/laravel .
```

Give permissions for all files and directories generated by docker user
```
sudo chown ${USER}:${USER} -R api
```

Set up Laravel permissions
```
sudo chmod -R 777 api/bootstrap/cache
sudo chmod -R 777 api/storage
```

Update environment variables and generate the Laravel application key
```
sudo rm api/.env
cp .env api/.env
docker-compose exec php-cli php artisan key:generate --ansi 
```

Install the Redis PHP client
```
docker-compose exec php-cli composer require predis/predis
```

Open [http://localhost:8081](http://localhost:8081) in your browser and make sure it works

**If you want to reinstall Nuxt.JS from scratch with a fresh version, use the following commands:**

Remove the old Nuxt directory and create a new empty one
```
sudo rm -rf client
mkdir client
```

Restart Docker containers to allow to remount the ```client``` directory
```
docker-compose restart
```

Create a new Nuxt project with preferable configurations (recommended: no custom server framework, universal rendering mode, yarn package manager)
```
docker-compose exec node-cli yarn create nuxt-app .
```

Give permissions for all files and directories generated by docker user
```
sudo chown ${USER}:${USER} -R client
```

Restart Docker containers again for stating the fresh Nuxt instance
```
docker-compose restart
```

Open [http://localhost:8080](http://localhost:8080) in your browser and make sure it works


#### Run commands from containers
```
# PHP
docker-compose exec php-cli bash

# NODE
docker-compose exec node-cli /bin/sh
```


##### TODO LIST:
- fix README.md
- add image to readme.md with connected containers and workflow explaining 
- add xDebug phpstorm tutorial
- add other containers (selenium, laravel-echo-server)
- add instructions about testing (and generate .env.testing file)
- migrate to SSL and probably HTTP2
- find and replace all hardcoded values with ENV variables 
- add pcntl and mbstring php extensions
- make containers smaller (probably cache php-cli build with all extensions for reusing from other containers)
