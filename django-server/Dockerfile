FROM ubuntu:14.04
MAINTAINER Tom Petit "contact@tompet.it"
CMD /root/docker_entrypoint.sh

RUN apt-get update -q
RUN apt-get install -y \
	nginx \
	python python-dev python-pip \
	sqlite3 libsqlite3-dev \
	supervisor \
	git

COPY docker_entrypoint.sh /root/

# install development essentials
WORKDIR /tmp/dev_env
COPY dev_env/ /tmp/dev_env
RUN /tmp/dev_env/development_env.sh

# change to working in the user's home.
WORKDIR /root

# Add the code base from git.
COPY ssh /root/.ssh
RUN chmod 700 /root/.ssh/github-deployment.pem
RUN ssh-keyscan github.com > /root/.ssh/known_hosts
RUN git clone git@github.com:leanrobot/contestsite.git

# Add local codebase
#COPY ./code/ /root/contestsite

# set up nginx site
RUN ln -s nginx /etc/nginx
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/sites-available /etc/nginx/sites-available/

RUN rm /etc/nginx/sites-enabled/*
RUN ln -s /etc/nginx/sites-available/contest-site \
		/etc/nginx/sites-enabled/contest-site

# Pip installs
RUN pip install gunicorn
RUN pip install -r ~/contestsite/requirements.txt

# Expose Ports
EXPOSE 80

# Supervisor env setup.
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/supervisord.conf

# create socket folder
RUN mkdir -p gunicorn
COPY gunicorn_config.py gunicorn/gunicorn_config.py

# setup log folder
RUN mkdir -p /root/logs/

# collectstatic for django files.
WORKDIR /root/contestsite
RUN python manage.py collectstatic --noinput
