## Client

This is where your Nuxt application is stored.

## Installation

The whole installation process is to create a shared network, build containers and initialize a new Nuxt application.

Run the installation script in your terminal, and it will do it all automatically:

```bash
./install.sh
```

Now you should be able to see it running in your browser at [http://localhost:3000](http://localhost:3000).

## Usage

All docker commands are abstracted into [Makefile](./Makefile) instructions.

They are very simple and often just instead of the `docker-compose` command you need to write `make` in your terminal.

Feel free to explore them and edit according to your needs.

### Start containers

```bash
# Make command
make up

# Full command
docker-compose -f docker-compose.dev.yml up -d
```

Now you can open [http://localhost:3000](http://localhost:3000) URL in your browser.

### Stop containers

```bash
# Make command
make down

# Full command
docker-compose -f docker-compose.dev.yml down
```

### Fetch API data

To fetch data from the Laravel API, you have to use different endpoints when requesting data from the browser and during the SSR process from the Node server instance.

The `.env` file already contains those endpoints, so you can use the following `nuxt.config.ts` file:

```ts
import { defineNuxtConfig } from 'nuxt3'

export default defineNuxtConfig({
  publicRuntimeConfig: {
    apiUrlBrowser: process.env.API_URL_BROWSER,
  },

  privateRuntimeConfig: {
    apiUrlServer: process.env.API_URL_SERVER,
  }
})
```

Then, you can create something like this composable function `/composables/apiFetch.ts`:

```ts
import type { FetchOptions } from 'ohmyfetch'

export const useApiFetch = (path: string, opts?: FetchOptions) => {
  const config = useRuntimeConfig()

  return $fetch(path, {
    baseURL: process.server ? config.apiUrlServer : config.apiUrlBrowser,
    ...(opts && { ...opts })
  })
}
```

Now in the component file you can use it as following:

```vue
<script setup>
const { data } = await useApiFetch('/products')
</script>
```

## To Do list

- [ ] add stub for nuxt 2
- [ ] add health checks
