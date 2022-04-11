#!/bin/sh

echo 'here'

#certbot renew

#certbot renew --pre-hook "service nginx stop" --post-hook "service nginx start"

## Renew containers (or maybe use --post-hook)
#docker-compose run --entrypoint certbot certbot renew
#
## Reload nginx (do it using docker_api)
#docker-compose exec -T nginx nginx -s reload
