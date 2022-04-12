# TODO

- [ ] add .env variable to different hosts, staging server, dry-run, 4096-bit keys and others
- [ ] generate overlay network for swarm
- [ ] www redirect to non-www
- [ ] add possibility to automatically generate conf from stub (default nginx template engine very often breaks with variables inside strings)
- [ ] configure nginx logging (forward into /std/err, add logrotate)
- [ ] forward letsencrypt logs
- [ ] add staging env variable
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
