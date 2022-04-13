#!/bin/sh

certbot renew \
    --non-interactive \
    --no-random-sleep-on-renew \
    --webroot \
    --webroot-path /var/www/acme \
    --force-renewal \
    --staging
