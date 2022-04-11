# TODO

- [ ] add hook to automatically reload nginx proxy container 
- [ ] add .env variable to different hosts, staging server and others
- [ ] set up crontab
- [ ] add possibility to generate 4096-bit key (from env variable)
- [ ] add install.sh script that copies .env file which is not ignored by git
- [ ] make nginx work even when some hosts are not available
- [ ] add dev env
- [ ] use 'gateway' network (add make command to create it)
- [ ] www redirect to non-www
- [ ] test ssl config:
  - https://securityheaders.com
  - https://www.ssllabs.com/ssltest 
  - https://www.humankode.com/ssl/how-to-set-up-free-ssl-certificates-from-lets-encrypt-using-docker-and-nginx

Sources:
- https://github.com/ebarault/letsencrypt-autorenew-docker
- https://github.com/wmnnd/nginx-certbot/blob/master/docker-compose.yml
- https://www.laradocker.com/production/#using-docker-compose
