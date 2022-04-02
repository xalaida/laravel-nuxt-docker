# Create an API app using sail image
docker run --rm -it \
    -u "$(id -u)":"$(id -g)" \
    -v "$(pwd)":/var/www/html \
    -w /var/www/html \
    laravelsail/php81-composer:latest \
    composer create-project --prefer-dist laravel/laravel api-sail

# Install Laravel Sail
docker run --rm -it \
    -u "$(id -u)":"$(id -g)" \
    -v "$(pwd)":/var/www/html \
    -w /var/www/html/api-sail \
    laravelsail/php81-composer:latest \
    php artisan sail:install
