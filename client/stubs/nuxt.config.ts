import { defineNuxtConfig } from 'nuxt3'

export default defineNuxtConfig({
    publicRuntimeConfig: {
        apiUrlBrowser: process.env.API_URL_BROWSER,
        apiUrlServer: process.env.API_URL_SERVER,
    }
})
