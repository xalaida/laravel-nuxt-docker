import { defineNuxtConfig } from 'nuxt3'

export default defineNuxtConfig({
    publicRuntimeConfig: {
        apiUrlBrowser: process.env.API_URL_BROWSER,
    },

    privateRuntimeConfig: {
        apiUrlServer: process.env.API_URL_SERVER,
    }
})
