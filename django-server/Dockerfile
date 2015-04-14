FROM ubuntu:14.04
MAINTAINER Tom Petit "contact@tompet.it"
CMD supervisord -n -c /etc/supervisord/supervisord.conf

RUN apt-get update -q

# install development essentials
WORKDIR /tmp/dev_env
COPY dev_env/ /tmp/dev_env
RUN /tmp/dev_env/development_env.sh

# change to working in the user's home.
WORKDIR /root

# Add the code base from git.
COPY ssh /root/.ssh
RUN chmod 700 /root/.ssh/github-deployment.pem
RUN apt-get install -yq git

RUN ssh-keyscan github.com > /root/.ssh/known_hosts
#RUN ssh -v git@github.com
RUN git clone git@github.com:leanrobot/contestsite.git

# Main site config
RUN apt-get install -y \
	nginx \
	python python-dev python-pip \
	sqlite3 libsqlite3-dev

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

# setup Gunicorn ====

# Install Supervisor
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor

# create socket folder
RUN mkdir -p gunicorn
COPY gunicorn_config.py gunicorn/gunicorn_config.py

COPY supervisord.conf /etc/supervisord/supervisord.conf