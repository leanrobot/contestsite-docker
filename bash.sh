#!/bin/bash
docker-compose -f docker-compose-dev.yml run --service-ports webserver /bin/bash
docker-compose -f docker-compose-dev.yml kill
docker-compose -f docker-compose-dev.yml rm -f
