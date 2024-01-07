## WEB

This directory houses your Nuxt application.

## Installation

To install the fresh Nuxt application, run the installation script from your terminal and follow the on-screen instructions:

```bash
./install.sh
```

Once the installation is complete, you can view your Nuxt application in your browser at [http://localhost:3000](http://localhost:3000).

## Environments

There are own docker compose file for each environment. For local development it could be useful to rename a `compose.local.yaml` file to `compose.yaml`. This allows to run docker compose command  without having to specify the specific compose file.

## Usage

### Building images

For example, to build images for local environment, use the following command:

```bash
docker compose -f compose.local.yaml build
```

### Start containers

To start the Docker containers, use the following command:

```bash
docker compose -f docker-compose.local.yaml up
```

Now, you can access your application at [http://localhost:3000](http://localhost:3000) in your browser.

### Stop containers

To stop the Docker containers, run the following command:

```bash
docker compose -f docker-compose.local.yaml down
```

### Fetching data

When fetching data from the Laravel API, use different endpoints for browser requests and server-side rendering (SSR) processes. Here's an example on how to do that:

```vue
<script setup>
const baseUrl = process.server
    ? 'http://api:8000'
    : 'http://localhost:8000'

const { data: posts } = await useFetch(`${baseUrl}/posts`)
</script>

<template>
	<h1>Posts</h1>

	<div>
		<div v-for="post in posts" :key="post.id">
			<h2>{{ post.title }}</h2>
		</div>
	</div>
</template>
```

Happy coding ☕
