# Remove existing app if "--clear" argument is provided
# TODO: refactor to just remove everything except provided files
for i in "$@" ; do
  if [[ $i == "--clear" ]] ; then
    rm -rf ./.nuxt
    rm -rf ./composables
    rm -rf ./layouts
    rm -rf ./node_modules
    rm -rf ./pages
    rm -rf ./plugins
    rm -rf ./public
    rm -f .gitignore
    rm -f app.vue
    rm -f nuxt.config.ts
    rm -f package.json
    rm -f README.md
    rm -f tsconfig.json
    rm -f yarn.lock
    break
  fi
done

# Init a new Nuxt app
docker-compose run --rm app npx nuxi init src

# Set ownership of the app to the current user
chown -R "$(id -u)":"$(id -g)" ./src

# Move all files and directories up one level
# TODO: rewrite without terminal errors
mv src/* src/.* .

# Remove 'src directory
rm -r src

# Use config
mv ./.env.local ./.env

# Install packages
docker-compose run --rm --user "$(id -u)":"$(id -g)" app yarn install
