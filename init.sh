#!/bin/bash

TMP_DIR="tmp"
ENV_FILE=".env"
VAR_FILE="variables.sh"
ENV_FILE_TEMPLATE="templates/.env.template"
DOCKER_COMPOSE_TEMPLATE="templates/docker-compose.yml.template"
TRAEFIK_TOML_FILE_TEAMPLATE="templates/traefik.toml.template"
SEPARATOR="========="

if [[ ! -f "$ENV_FILE" ]]; then
    echo "No '$ENV_FILE' file found."
    echo "Creating the default '$ENV_FILE' file based on the following template: '$ENV_FILE_TEMPLATE'"
    cat "$ENV_FILE_TEMPLATE" > "$ENV_FILE"
    echo "Default '$ENV_FILE' file content:"
    echo "$SEPARATOR"
    cat "$ENV_FILE"
    echo "$SEPARATOR"
    echo "TODO: Specify missing variables in '$ENV_FILE' first."
    exit 0
fi

echo "Creating temporary directory '$TMP_DIR'."
mkdir "$TMP_DIR"
echo "Creating environment variables file ('$VAR_FILE') in '$TMP_DIR'."
sed -e 's/^/export /' "$ENV_FILE" > "$TMP_DIR/$VAR_FILE"
echo

echo "Exporting environment variables:"
echo "$SEPARATOR"
cat "$ENV_FILE"
echo "$SEPARATOR"
source "$TMP_DIR/$VAR_FILE" > /dev/null
echo

echo "Deleting temporary directory."
rm -rf "$TMP_DIR"
echo

if [[ -z "$TRAEFIK_DOCKER_DOMAIN" || -z "$TRAEFIK_ACME_EMAIL" ]]; then
    echo "Missing some environment variables in '$ENV_FILE' file."
    echo "TODO: Specify missing variables in '$ENV_FILE' first."
    exit 1
fi

echo "Creating docker-compose.yml file based on the following template: '$DOCKER_COMPOSE_TEMPLATE'"
envsubst < "$DOCKER_COMPOSE_TEMPLATE" | cat > docker-compose.yml
echo "Creating docker network: '$EXTERNAL_NETWORK'"
DOCKER_NETWORK_CREATE_RESULT=$(docker network create "$EXTERNAL_NETWORK")
if [[ "$?" = 0 ]]; then
    echo "Hash for network '$EXTERNAL_NETWORK': $DOCKER_NETWORK_CREATE_RESULT"
else
    echo "Hint: Error from daemon expected."
fi
echo

echo "Creating traefik.toml file based on the following template: '$TRAEFIK_TOML_FILE_TEAMPLATE'"
envsubst < "$TRAEFIK_TOML_FILE_TEAMPLATE" | cat > config/traefik.toml

echo
echo "Start Traefik with 'docker-compose up -d'"
echo "Logs (docker logs traefik) will be at a minimum, because the log level is on ERROR"