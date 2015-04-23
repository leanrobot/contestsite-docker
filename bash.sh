#!/bin/bash

docker rm -f contestsite rabbitmq celeryworker
docker run -d --name rabbitmq rabbitmq:latest 
docker run -d -e C_FORCE_ROOT=true --name celeryworker -v ~/programming/ContestSite/django:/root/contestsite --link rabbitmq:broker leanrobot/contestsite python manage.py celery worker
docker run --rm -t -i -p 8080:80 --link rabbitmq:broker --link celeryworker:worker \
	--name contestsite \
	-v ~/programming/ContestSite/django:/root/contestsite \
	-v ~/programming/ContestSite/db.sqlite:/root/contestsite/db.sqlite \
	leanrobot/contestsite /bin/bash
