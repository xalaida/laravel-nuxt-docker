alias own='sudo chown -R $(id -u):$(id -g)'

alias artisan='docker-compose exec --user "$(id -u):$(id -g)" php-cli php artisan'
alias from='docker-compose exec'

alias test='docker-compose exec php-cli vendor/bin/phpunit'
alias tf='docker-compose exec php-cli vendor/bin/phpunit --filter'
alias tfc='docker-compose exec php-cli vendor/bin/phpunit  --coverage-html tests/report --filter'
