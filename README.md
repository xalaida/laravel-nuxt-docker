[![Stand With Ukraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner-direct-single.svg)](https://stand-with-ukraine.pp.ua)

# Dockerized template for your next project with Laravel and Nuxt

Well tested on Ubuntu 18.04, 19.10 and 20.04.

## 🍬 Stack includes

* API
  * Laravel (latest version)
  * Octane
  * PostgreSQL (and separate database for testing)
  * Redis
  * MailHog
* Client
  * Nuxt 3 (latest version)
* Gateway
  * Nginx (as reverse-proxy)
  * Certbot

## 📜 Introduction

The project is just separate preconfigured Laravel and Nuxt applications that are stored in the same [monorepo](https://en.wikipedia.org/wiki/Monorepo). 

Each app has its own docker templates for development and production and does not have the actual application code.
So you can install and run them completely separate from each other.
There are also no restrictions to add more, for example, a mobile application or an admin panel.

### Single host

If you want to host API and client apps on the single host machine, you may set up subdomains rather than rely on published ports.

The project includes a simple gateway application that can easily help with this.

It can be also useful to run locally and set up an application to use subdomains and test CORS and other possible issues.

Of course, you can replace it with a more professional tool, like [Traefik](https://traefik.io).

## ⚙ Installation

1. Clone or download the repository and enter its directory:

```bash
git clone https://github.com/nevadskiy/laravel-nuxt-docker.git app
cd app
```

2. Install the `api` application.

```bash
cd api
./install.sh
```

This will install and run a fresh new Laravel app which will be available on `http://localhost:8000`.

3. Install the `client` application.

```bash
cd client
./install.sh
```

This will install and run a fresh new Nuxt 3 app which will be available on `http://localhost:3000`.

4. (Optional) If you want to deploy your project using [single host](#single-host) approach, install the `gateway` application according to its documentation. Otherwise, you can safely delete it. For local development you can ignore it as well.

## 🔌 Network communication

The following image demonstrates the request paths in a local development environment.

![Networking](docs/networking.png)

API and WEB requests sent by the browser are proxied directly via published ports to the running server instances.

But the SSR request is sent by the node server, not the browser, and should be sent directly to the host of the API docker service.

## 📑 Documentation

- [API](./api/DOCUMENTATION.md)
- [Client](./client/DOCUMENTATION.md)
- [Deployment](./docs/DEPLOYMENT.md)

## ☕ Contributing

If you see anything that can be improved, feel free to make a pull request.
Contributions are welcome and will be fully credited.
