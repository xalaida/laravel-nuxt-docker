#!/bin/sh

certbot renew \
    --non-interactive \
    --webroot \
    --webroot-path /var/www/acme \
    --post-hook /scripts/nginx-reload.sh
    # --force-renewal \
    # --no-random-sleep-on-renew \
    # --staging
