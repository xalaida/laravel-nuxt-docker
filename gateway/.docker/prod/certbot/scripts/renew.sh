#!/bin/sh

echo 'Start renewing certificates'
certbot renew --webroot --webroot-path /var/www/acme --force-renewal --staging -dry-run

#echo 'Restarting gateway service'

# Extract into certbot hook (certbot renew --pre-hook "service nginx stop" --post-hook "service nginx start")
# TODO: get container name from ENV variable
#curl --unix-socket /var/run/docker.sock -X POST http://v1.41/containers/reverse-proxy/restart

# TODO: replace restart command above with 'nginx -s reload' command using 'exec' API (commands below does not work)
# curl --unix-socket /var/run/docker.sock -X POST http://v1.41/containers/reverse-proxy/exec -d '{"Cmd": ["nginx", "-s", "reload"]}' -H "Content-Type: application/json"
# curl --unix-socket /var/run/docker.sock -X POST http://v1.41/containers/reverse-proxy/exec -d '{"Cmd": ["/bin/sh", "-c", "nginx -s reload"]}' -H "Content-Type: application/json"

echo 'Certificates have been renewed'
