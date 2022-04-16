## Client

Your Nuxt app will be placed in the `/client` directory.

## Installation

To build and install a new Nuxt app, execute the `install.sh` script:

```bash
cd client
./install.sh
```

### Usage

#### Start

To start containers, run the command:

```bash
# Make command
make up

# Raw command
docker-compose up -d
```

Now, you can open [http://localhost:3000](http://localhost:3000) URL in your browser.

#### Stop

To stop containers, run the command:

```bash
# Make command
make down

# Raw command
docker-compose down
```

#### Fetch API data

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
