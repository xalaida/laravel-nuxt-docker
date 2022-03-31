# Execute command from specified container.
alias from='docker-compose exec'

# Execute command from specified container from the current user.
alias owning='docker-compose exec --user "$(id -u):$(id -g)"'

# Run artisan commands
alias artisan='docker-compose exec --user "$(id -u):$(id -g)" php php artisan'

# Simple testing aliases
alias test='docker-compose exec php vendor/bin/phpunit'
alias tf='docker-compose exec php vendor/bin/phpunit --filter'
alias tfc='docker-compose exec php vendor/bin/phpunit  --coverage-html tests/report --filter'
alias ts='docker-compose exec php vendor/bin/phpunit --testsuite'
alias tsc='docker-compose exec php vendor/bin/phpunit --coverage-html tests/report --testsuite'
