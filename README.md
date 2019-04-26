# Traefik setup with Let's Encrypt certificates (https)

## Installation
Execute `init.sh` and follow the instructions. This will do the following:

* Create a `.env` file where some variables will have default values and some have to be set manually
* Create the `config/traefik.toml` file, which is the configuration for your Traefik instance *(Based on `env` file)*
* Create a `docker-compose.yml` file *(Based on `env` file)*
* Create a docker network with the name you've specified in your `.env` file *(Based on `env` file)*

**Important**: You have to execute the script at least **two** times, because you have to set the environment variables first before any other files can be created.

## Start Traefik

`docker-compose up -d`

## Include other services into Traefik

Here are some important aspects that Traefik can find your docker services:

1. The service has to be part of the same docker network as your Traefik instance
2. The labels of your service/container have to be conform to the latest version of Traefik

More info about labels: [https://docs.traefik.io/configuration/backends/docker/](https://docs.traefik.io/configuration/backends/docker/)

An example configuration of a separate service where the routing will be managed by Traefik can be found in the `sample-services` folder.

## Soon

More instructions coming soon :heart:
