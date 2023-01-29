[![Stand With Ukraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner-direct-single.svg)](https://stand-with-ukraine.pp.ua)

# Dockerized template for your next project with Laravel and Nuxt

Well tested on Ubuntu 18.04, 19.10 and 20.04.

## 🍬 Stack includes

* API
  * Laravel (latest version)
  * Octane / PHP-FPM
  * PostgreSQL (and separate database for testing)
  * Redis
  * MailHog
* Client
  * Nuxt 2 / 3 (latest version)
* Gateway
  * Nginx (as reverse-proxy)
  * Certbot

## 📜 Introduction

The project is just separate pre-configured Laravel and Nuxt applications that are stored in the same [monorepo](https://en.wikipedia.org/wiki/Monorepo). 

Each app has its docker templates for development and production and does not have the actual application code.
So you can install and run them completely separately from each other.
There are also no restrictions to adding more, for example, a mobile or an admin panel application.

## ⚙ Installation

Clone or download the repository and enter its directory:

```bash
git clone https://github.com/nevadskiy/laravel-nuxt-docker.git app
cd app
```

### API

#### Quick installation

```bash
cd api
./install
```

This will install and run a fresh new Laravel app which will be available on `http://localhost:8000`.

#### Advanced installation

Read more about an [advanced API installation](./api/DOCUMENTATION.md).

### Client

#### Quick installation

```bash
cd client
./install
```

This will install and run a fresh new Nuxt 3 app which will be available on `http://localhost:3000`.

#### Advanced installation

Read more about an [advanced client installation](./client/DOCUMENTATION.md).

### Gateway (optional)

#### Single host

If you want to host API and client apps on the single host machine, you may set up subdomains rather than rely on published ports.

The project includes a simple gateway application that can easily help with this.

It can also be useful to run locally and set up an application to use subdomains and test CORS and other possible issues.

If you want to deploy your project using the "single host" approach, install the `gateway` application according to [its documentation](./gateway/README.md). 
Otherwise, you can safely delete it. 
For local development you can ignore it completely.

Of course, you can replace it with a more professional tool, like [Traefik](https://traefik.io).

## 🔌 Network communication

The following image demonstrates the request paths in a local development environment.

![Networking](docs/networking.png)

API and WEB requests sent by the browser are proxied directly via published ports to the running server instances.

But the SSR request is sent by the node server, not the browser, and should be sent directly to the host of the API docker service.

## 📑 Documentation

- [API](./api/DOCUMENTATION.md)
- [Client](./client/DOCUMENTATION.md)
- [Gateway](./gateway/README.md)
- [Deployment](./docs/DEPLOYMENT.md)

## ☕ Contributing

If you see anything that can be improved, feel free to make a pull request.
Contributions are welcome and will be fully credited.
