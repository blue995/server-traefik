# Sample configuration

## Installation

It is important that you've executed the `init.sh` script correctly and configured your `.env` with the environment variables of your choice.

## docker-compose.yml

This is a separate `docker-compose.yml` file with the following services:

* `whoami`: Simple web page with the content of the result of a `whoami` script execution
* `flask`: Hello world flask application

All services are connected to an external network `web` and an internal network `internal`.

The external network `web` has it's name from the `.env` file and was created during the `init.sh` script.

The connections of the services with the `web` network allow Traefik to discover the services and adjust it's configuration automatically after the service containers start up.

After you've started the service containers the services will be reachable by the following URLs:

* whoami: [https://your.domain.tld](https://your.domain.tld)
* whoami: [https://whoami.your.domain.tld](https://whoami.your.domain.tld)
* whoami: [https://domain.tld/whoami](https://domain.tld/whoami)
* flask: [https://domain.tld/flask](https://domain.tld/flask)
