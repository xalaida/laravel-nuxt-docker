# TODO

- [ ] add install.sh
    - make .env
    - build
    - generate ssl certificates
    - generate dh params
    - generate templates from stubs
    - run
- [ ] www redirect to non-www
- [ ] add staging env variable
- [ ] add .env variable to different hosts, staging server, dry-run, 4096-bit keys and others
- [ ] add possibility to automatically generate conf from stub (default nginx template engine very often breaks with variables inside strings)
- [ ] generate overlay network for swarm
- [ ] configure nginx logging (forward into /std/err, add logrotate)
- [ ] forward letsencrypt logs
- [ ] add dev env

## Certbot commands 

Issue certificate

```
docker-compose run --rm certbot certonly --agree-tos --no-eff-email --webroot --webroot-path /var/www/acme -d example@domain.com

certonly --webroot --register-unsafely-without-email --agree-tos --webroot-path=/data/letsencrypt --staging -d example.com -d www.example.com

certbot certonly --standalone -d ${DOMAINNAME} --text --agree-tos --email you@example.com --rsa-key-size 4096 --verbose
```

## Sources

- https://github.com/docker-library/docs/tree/master/nginx
- https://eff-certbot.readthedocs.io/en/stable/install.html#running-with-docker
