FROM ubuntu:14.04
MAINTAINER Tom Petit "contact@tompet.it"
CMD supervisord -n -c /etc/supervisord/supervisord.conf

WORKDIR /root

RUN apt-get update -q

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
	python

# set up nginx site
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/sites-available /etc/nginx/sites-available/

RUN rm /etc/nginx/sites-enabled/*
RUN ln -s /etc/nginx/sites-available/contest-site \
		/etc/nginx/sites-enabled/contest-site

# Pip installs

# Expose Ports
EXPOSE 80

# Install Supervisor
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor

COPY supervisord.conf /etc/supervisord/supervisord.conf