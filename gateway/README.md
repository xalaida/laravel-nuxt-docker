# TODO

- [ ] add .env variable to different hosts, staging server, dry-run, 4096-bit keys and others
- [ ] make nginx work even when some hosts are not available
- [ ] www redirect to non-www
- [ ] add stub samples for different hosts (laravel, nuxt, etc)
- [ ] refactor nginx reloading
  - [ ] get reverse-proxy container name from ENV variable
  - [ ] reload nginx using 'exec nginx -s reload' syntax
  - [ ] reload using certbot hooks
- [ ] add dev env
- [ ] add install.sh --dev script

Sources:
- https://github.com/ebarault/letsencrypt-autorenew-docker
- https://github.com/wmnnd/nginx-certbot/blob/master/docker-compose.yml
- https://www.laradocker.com/production/#using-docker-compose
