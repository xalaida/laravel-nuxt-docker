# Stop all containers
docker-compose down

# Remove client directory
sudo rm -rf ./client

# Init a new Nuxt app
docker-compose run \
  --rm \
  client-app \
  npx nuxi init ../client

# Set ownership of the app to the current user
sudo chown -R $(id -u):$(id -g) ./client
