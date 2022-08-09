# Deployment

## Single host & Git & Docker Compose

The simplest solution is to deploy apps on a single host and using only Git and Docker Compose.

To do that, you need to set up some `proxy` in front of both `client` and `api` apps.

## Steps

1. Connect to the host via SSH.

2. Install Git, Docker, and Docker Compose.

3. Clone your app, for example, to the `/var/www` directory. 

4. Create shared docker network.

5. Set up the `API` application.
    - Copy `.env.prod` file to `.env` and fill it according to your needs.
    - Build containers using `make build` command.
    - Run containers using `make up` command.

6. Set up the `client` application.
    - Copy `.env.prod` file to `.env` and fill it according to your needs.
    - Build containers using `make build` command.
    - Run containers using `make up` command.

7. Set up the `reverse proxy` application.
