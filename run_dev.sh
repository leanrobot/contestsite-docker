#!/bin/bash
# run rabbitmq
docker rm -fq contestsite rabbitmq celeryworker
rabbitmq_id=$(docker run -d --name rabbitmq rabbitmq:latest)
worker_id=$(docker run -d  --name celeryworker leanrobot/contestsite
	python manage.py celery worker)
docker run --rm -t -i -p 8080:80 --link rabbitmq:broker --name contestsite -v \
	~/programming/ContestSite/django:/root/contestsite \
	leanrobot/contestsite

