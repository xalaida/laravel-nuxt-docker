## Client

This is where your Nuxt application is stored.

## Installation

The whole installation process is to create a shared network, build containers and initialize a new Nuxt application.

Run the installation script in your terminal, and it will do it all automatically:

```bash
./install.sh
```

Now you should be able to see it running in your browser at [http://localhost:3000](http://localhost:3000).

## Installation to existing project

1. Copy all files from the `client` directory to your application.
2. Create the `.env` file from `.env.dev`.
3. Build and run containers using the command `make install`.

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

#### Nuxt 2

For Nuxt 2 app you need to configure `axios` in the `nuxt.config.js` file like this:

```js
{
  publicRuntimeConfig: {
    axios: {
      browserBaseURL: process.env.API_URL_BROWSER
    }
  },

  privateRuntimeConfig: {
    axios: {
      baseURL: process.env.API_URL_SERVER
    }
  },
}
```

Now in the component file you can use it like this:

```vue
<script>
export default {
  async asyncData ({ $axios }) {
    const { data } = await $axios.$get('/products')
  }
}
</script>
```

## Nuxt 2 version

If you want to use Nuxt 2, you need to copy all files from `stubs/nuxt2` directory to the base `client` directory and then follow [the installation instructions](#installation).
