# Execute commands from any container
alias from='docker-compose exec'

# Change owner for current user
alias own='sudo chown -R $(id -u):$(id -g)'

# Run artisan commands
alias artisan='docker-compose exec --user "$(id -u):$(id -g)" php php artisan'

# Simple testing aliases
alias test='docker-compose exec php vendor/bin/phpunit'
alias tf='docker-compose exec php vendor/bin/phpunit --filter'
alias tfc='docker-compose exec php vendor/bin/phpunit  --coverage-html tests/report --filter'
alias ts='docker-compose exec php vendor/bin/phpunit --testsuite'
alias tsc='docker-compose exec php vendor/bin/phpunit --coverage-html tests/report --testsuite'
