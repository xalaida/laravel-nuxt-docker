# About (Currently work in progress)
Dockerized started template for Laravel + Nuxt.JS easy development

Clone and go!

## Available containers
* Nginx (as proxy resolver between Laravel and Nuxt)
* PHP-FPM version 7.3
* Node version 12.4 (For SSR)
* Redis
* PostgreSQL version 11.3

* NODE-CLI for front-end workspace
* PHP-CLI for back-end workspace

### TODO LIST:
- update PHP to 7.3
- add instructions about reinstallation nuxt and laravel with fresh versions
- install eslinter
- add IDE settings instructions (optional)
- add logs to .gitignore
- add docker ignore
- add other containers
- migrate to SSL and probably HTTP2
- add instructions about axios usage
- add node-cli container
- proxy redis port (for gui tools access)
- add commands for postgres usage
- add commands for displaying logs
- add commands for clearing logs

### Installing nuxt:
1. Remove old client directory:
```
sudo rm -rf client
```

2. Create fresh nuxt project
```
yarn create nuxt-app client
```


### Installing fresh laravel:
1. Remove old client directory:
```
sudo rm -rf api
```
2. Create fresh laravel project
```
yarn create nuxt-app client
```
3. Set up permissions

