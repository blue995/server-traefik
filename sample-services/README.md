# Sample configuration

## Installation

It is important that you've executed the `init.sh` script correctly and configured your `.env` with the environment variables of your choice.

## docker-compose.yml

This is a separate `docker-compose.yml` file with one `whoami` service that is connected to an external network `web` and an internal network `internal`. The external network `web` has it's name from the `.env` file and was created during the `init.sh` script. The connection of the `whoami` service with the `web` network allows Traefik to discover the service and adjust it's configuration automatically after the `whoami` service container starts up.

After you've started the `whoami` service container the service will be reachable by the following URLs:

* [https://your.domain.tld](https://your.domain.tld)
* [https://whoami.your.domain.tld](https://whoami.your.domain.tld)
* [https://domain.tld/whoami](https://domain.tld/whoami)