#!/bin/sh

# Make a 'GET' request on the docker socket
docker_socket_get() {
    local API_PATH="${1?Missing path}"

    curl -s -f --unix-socket /var/run/docker.sock "http://v1.41${API_PATH}"
}

# Make a 'POST' request on the docker socket
docker_socket_post() {
    local API_PATH="${1?Missing path}"
    local API_FORM_DATA="${2?Missing form data}"

    curl -s --unix-socket /var/run/docker.sock "http://v1.41${API_PATH}" \
        -X POST \
        -H "Content-Type: application/json" \
        -d "${API_FORM_DATA}"
}

# Exec the command on the given container using the docker socket
docker_socket_exec() {
    local CONTAINER="${1?Missing container}";
    local EXEC_COMMAND="${2?Missing command}";

    # Prepare form data
    local FORM_DATA; FORM_DATA=$(printf '{"AttachStdin": false, "AttachStdout": true, "AttachStderr": true, "Tty":false, "Cmd": %s}' "${EXEC_COMMAND}")

    # Prepare execution
    local EXEC_ID=$(docker_socket_post "/containers/${CONTAINER}/exec" "${FORM_DATA}" | jq -r '.Id')

    # Start execution
    docker_socket_post "/exec/${EXEC_ID}/start" '{"Detach": false, "Tty": false}'
}

# Get container
get_container_id_by_service() {
    local SERVICE="${1?Missing service}";

    docker_socket_get "/containers/json" | jq -r '.[] | select(.Labels["com.docker.compose.service"] == "reverse-proxy") | .Id'
}

# Reload the Nginx service
reload_nginx_service() {
    # Get container ID
    local CONTAINER_ID=$(get_container_id_by_service "${NGINX_SERVICE}")

    # Reload nginx service
    docker_socket_exec "${CONTAINER_ID}" '["nginx", "-s", "reload"]'
}

# Execution
if [ -z "${NGINX_SERVICE}" ]; then
    echo "NGINX_SERVICE variable is empty. Nothing to reload."
    return 1
else
    echo "Reloading Nginx Service."
    reload_nginx_service
fi
