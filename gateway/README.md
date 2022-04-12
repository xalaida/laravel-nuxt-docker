# TODO

- [ ] add .env variable to different hosts, staging server, dry-run, 4096-bit keys and others
- [ ] make nginx work even when some hosts are not available
- [ ] generate overlay network for swarm
- [ ] www redirect to non-www
- [ ] add stub samples for different hosts (laravel, nuxt, etc)
- [ ] add conf templates
- [ ] refactor nginx reloading
  - [ ] get reverse-proxy container name from ENV variable
  - [ ] reload nginx using 'exec nginx -s reload' syntax
  - [ ] reload using certbot hooks
- [ ] add dev env
- [ ] add install.sh --dev script


## Certbot commands 

Issue certificate

```
docker-compose run --rm certbot certonly --agree-tos --no-eff-email --webroot --webroot-path /var/www/acme -d example@domain.com

certonly --webroot --register-unsafely-without-email --agree-tos --webroot-path=/data/letsencrypt --staging -d example.com -d www.example.com

certbot certonly --standalone -d ${DOMAINNAME} --text --agree-tos --email you@example.com --rsa-key-size 4096 --verbose
```
