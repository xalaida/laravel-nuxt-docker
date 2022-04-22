# Installation

**Step 1.** Copy the `.env.prod` file to the `.env` file and edit it according to your needs.

```
# List all your domains for which you want to issue SSL certificates
LETSENCRYPT_DOMAINS=example.com,www.example.com,api.example.com

# Specify your email
LETSENCRYPT_EMAIL=example@mail.com
```

**Step 2.** Update templates for desired hosts.

Go to the `reverse-proxy/prod/sites-enabled` directory and replace `example.com` with your domain (without `www`) for each occurrence.

**Step 3.** Create gateway network.

It will be used in all proxied services.

```bash
docker network create gateway
```

**Step 4.** Build containers.

```bash
make build
```

**Step 5.** Issue certificate.

To verify that everything is set up correctly before generating the actual certificate, run the command:

```bash
make ssl.cert.test
```

Then, if you see the message "The dry run was successful.", issue the actual certificate using the command:

```
make ssl.cert
```

**Step 6.** Generate `dhparam` file.

```bash
make ssl.dh
```

**Step 7.** Start containers.

```bash
make up
```

## TODO

- [ ] fix case when proxy crashes when one upstream not found:
  - https://serverfault.com/questions/700894/make-nginx-ignore-site-config-when-its-upstream-cannot-be-reached
  - https://gist.github.com/dancheskus/8d26823d0f5633e9dde63d150afb40b2
- [ ] add install script
- [ ] add proxy mapping in case when 2 layers of proxy is used (reverse-proxy -> php-fpm-proxy -> php)
- [ ] use staging env variable
- [ ] add command to reissue cert according to new params
- [ ] add possibility to automatically generate conf from stub (default nginx template engine very often breaks with variables inside strings)
- [ ] generate overlay network for swarm
- [ ] configure logging
  - [ ] probably disable access.log
  - [ ] forward nginx logs from nginx.conf into /std/err
  - [ ] add logrotate 
  - [ ] forward letsencrypt logs to docker collector
  - [ ] integrate with prometheus
- [ ] filling /etc/hosts
- [ ] generate local cert


## Links

- https://github.com/docker-library/docs/tree/master/nginx
- https://eff-certbot.readthedocs.io/en/stable/install.html#running-with-docker


### Maintenance

View log size

```bash
du -h $(docker inspect --format='{{.LogPath}}' $(docker ps -qa))
```

View list of containers

```bash
docker container ls
```

Stop all running docker containers

```bash
docker kill $(docker ps -q)
```

Remove all running docker containers

```bash
docker rm $(docker ps -a -q)
```
