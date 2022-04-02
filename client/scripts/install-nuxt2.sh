# Remove existing app if "--clear" argument is provided
# TODO: refactor to just remove everything except provided files
for i in "$@" ; do
    if [[ $i == "--clear" ]] ; then
        rm -rf ./src
        rm -rf ./components
        rm -rf ./node_modules
        rm -rf ./pages
        rm -rf ./static
        rm -rf ./store
        rm .editorconfig
        rm .gitignore
        rm nuxt.config.js
        rm package.json
        rm README.md
        rm yarn.lock
        break
    fi
done

# Use correct stub for the app container
rm -rf ./.docker/dev/app
cp cp ./docker/stubs/nuxt2  ./.docker/dev/app

# Init a new Nuxt app
docker-compose run --rm app yarn create nuxt-app src

# Set ownership of the app to the current user
chown -R "$(id -u)":"$(id -g)" ./src

# Move all files and directories up one level
# TODO: rewrite without terminal errors
mv src/* src/.* .

# Remove 'src directory
rm -r src

# Use config
mv ./.env.local ./.env

# TODO: print instructions what to do next (copy code to nuxt.config.js)
