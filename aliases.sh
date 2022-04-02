# Execute command from the client-app container by the current user.
alias client='docker-compose exec --user "$(id -u):$(id -g)" client-app'

# Execute command from the api-app container by the current user.
alias api='docker-compose exec --user "$(id -u):$(id -g)" api-app'

# Execute command from specified container.
alias from='docker-compose exec'

# Execute command from specified container by the current user.
alias owning='docker-compose exec --user "$(id -u):$(id -g)"'

# Run artisan commands
alias artisan='docker-compose exec --user "$(id -u):$(id -g)" api-app php artisan'

# Simple testing aliases
alias test='docker-compose exec php vendor/bin/phpunit'
alias tf='docker-compose exec php vendor/bin/phpunit --filter'
alias tfc='docker-compose exec php vendor/bin/phpunit  --coverage-html tests/report --filter'
alias ts='docker-compose exec php vendor/bin/phpunit --testsuite'
alias tsc='docker-compose exec php vendor/bin/phpunit --coverage-html tests/report --testsuite'
