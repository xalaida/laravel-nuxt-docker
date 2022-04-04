# Build the client containers
docker-compose build

# Init a new Nuxt app
docker-compose run --rm --user "$(id -u)":"$(id -g)" app npx nuxi init src

# Set ownership of the app to the current user
chown -R "$(id -u)":"$(id -g)" ./src

# Move all files and directories up one level
# TODO: rewrite without terminal errors
mv src/* src/.* .

# Remove 'src directory
rm -r src

# Copy .env file
if [ ! -f ./.env ]; then
    cp ./.env.dev ./.env
fi

# Install packages
docker-compose run --rm --user "$(id -u)":"$(id -g)" app yarn install

# Print the final message
echo "Nuxt has been installed"
