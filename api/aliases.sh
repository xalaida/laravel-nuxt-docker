#TODO: feature 'salo' app that forwards common calls

# Execute command from the app container by the current user
alias api='docker-compose -f docker-compose.dev.yml exec --user "$(id -u):$(id -g)" app'

# Execute command from specified container
alias from='docker-compose -f docker-compose.dev.yml exec'

# Execute command from specified container by the current user
alias owning='docker-compose -f docker-compose.dev.yml exec --user "$(id -u):$(id -g)"'

# Run artisan commands
alias artisan='docker-compose -f docker-compose.dev.yml exec --user "$(id -u):$(id -g)" app php artisan'

# Testing aliases
alias test='docker-compose -f docker-compose.dev.yml exec app vendor/bin/phpunit'
alias tf='docker-compose -f docker-compose.dev.yml exec app vendor/bin/phpunit --filter'
alias ts='docker-compose -f docker-compose.dev.yml exec app vendor/bin/phpunit --testsuite'
