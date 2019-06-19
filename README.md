### TODO LIST:
- separate volume directories (client and api)
- update PHP to 7.3
- add instructions about reinstallation nuxt and laravel with fresh versions

- install eslinter
- add logs to .gitignore
- add docker ignore

- add command for restarting node

### Installing nuxt:
1. Remove old client directory:
```
sudo rm -rf client
```

2. Create fresh nuxt project
```
yarn create nuxt-app client
```


### Installing laravel:
1. Remove old client directory:
```
sudo rm -rf api
```
2. Create fresh laravel project
```
yarn create nuxt-app client
```
3. Set up permissions

#### Next steps:
- figure it out with errors in console about websockets (try the same with fresh nuxt)
- add instructions about axios usage (maybe avoid using plugin)
- add php-fpm proxy with nginx by prefix /api 
