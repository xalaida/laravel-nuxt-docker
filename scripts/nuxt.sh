# Stop all containers
docker-compose down

# Remove client directory
rm -rf ./../client

# Install Nuxt
docker-compose run --rm client-app npx nuxi init ../client

# Copy .env file
cp ./../docker/dev/client/.env ./../client/.env
echo "Added environment file."
