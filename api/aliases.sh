# Execute command from the app container by the current user
alias api='docker-compose exec --user "$(id -u):$(id -g)" app'

# Execute command from specified container
alias from='docker-compose exec'

# Execute command from specified container by the current user
alias owning='docker-compose exec --user "$(id -u):$(id -g)"'

# Run artisan commands
alias artisan='docker-compose exec --user "$(id -u):$(id -g)" app php artisan'

# Testing aliases
alias test='docker-compose exec app vendor/bin/phpunit'
alias tf='docker-compose exec app vendor/bin/phpunit --filter'
alias ts='docker-compose exec app vendor/bin/phpunit --testsuite'
