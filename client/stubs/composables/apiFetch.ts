import type { FetchOptions } from 'ohmyfetch'

export const useApiFetch = (path: string, opts?: FetchOptions) => {
  const config = useRuntimeConfig()

  return $fetch(path, {
    baseURL: process.server ? config.apiUrlServer : config.apiUrlBrowser,
    ...(opts && { ...opts })
  })
}
