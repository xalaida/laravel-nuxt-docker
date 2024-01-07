# Reverse Proxy

In this setup, we use Traefik as a reverse-proxy server, which offers easy configurability for efficient routing of incoming requests. It is designed for simplicity in both usage and configuration.

## Installation

To begin, you may need to configure your local hosts by editing the `/etc/hosts` file. For instance:

```
# Virtual Hosts
127.0.0.1 api.host.local
127.0.0.1 web.host.local
```

## Usage

While developing a Nuxt application, it would be more simple to use direct API endpoints without running Traefik at all.
However, if Traefik server is desired, you can use the `compose.local.yaml` file for this purpose.

For production environment there is a `compose.production.yaml` file. 

For production environments, utilize the compose.production.yaml file.

### Start containers

Execute the following command to start the containers:

```bash
docker compose -f compose.local.yaml up
```

Now, you can access your services using the configured virtual hosts.

Additionally, Traefik provides a visually appealing dashboard accessible at [localhost:8080](http://localhost:8080).

### Stop containers

```bash
docker compose -f compose.local.yaml down
```

Feel free to modify the configuration files to suit your project's needs.
