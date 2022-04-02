#!/bin/bash

# Stop all containers
docker-compose down

# Remove folders
sudo rm -rf ./.nuxt
sudo rm -rf ./composables
sudo rm -rf ./layouts
sudo rm -rf ./node_modules
sudo rm -rf ./pages
sudo rm -rf ./plugins
sudo rm -rf ./public

# Remove files
sudo rm -f .gitignore
sudo rm -f app.vue
sudo rm -f nuxt.config.ts
sudo rm -f package.json
sudo rm -f README.md
sudo rm -f tsconfig.json
sudo rm -f yarn.lock

# Print final message
echo "Done"
