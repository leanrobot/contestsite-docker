# Introduction

The following document describes the process for using this docker repository to set up the corresponding project. The application source code is located at: https://github.com/leanrobot/contestsite.

# Installation


## Prerequisites

- Ubuntu server 14.04 LTS (tutorial written using this OS, anything with docker support will work, installation will differ.)
- SSH access to the machine.
- Root or sudo access.

## Update Server

First update the server to make sure that all repositories and packages are on
the latest version.

```bash
sudo apt-get update -y
sudo apt-get upgrade -y
sudo aptitude install linux-image-extra-`uname -r`
```

## Install Software

### Install Docker

First we need to add the docker repository to our apt sources.

(The docker instructions are source from Digital Ocean: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-getting-started)
```bash
sudo sh -c "wget -qO- https://get.docker.io/gpg | apt-key add -" # add repo key
sudo sh -c "echo deb http://get.docker.io/ubuntu docker main > \
/etc/apt/sources.list.d/docker.list" # add repo to sources
```

Now that the key and repo have been added, let's install Docker.
```bash
sudo apt-get update -y
sudo apt-get install -y lxc-docker
```

### Configure Firewall

The Ubuntu firewall is configured by default to drop all forwarded traffic. This feature is required by docker. 

The following commands update the firewall policy to change DEFAULT_FORWARD_POLICY from DROP to ACCEPT and restart the firewall.
```bash
sudo sed -i '/DEFAULT_FORWARD_POLICY/c\DEFAULT_FORWARD_POLICY=\"ACCEPT\"' /etc/default/ufw
sudo ufw reload
```

### Other Software
The rest of our software can be easily installed via  normal package repositories.
```bash
sudo apt-get install -y git docker python python-pip
sudo pip install docker-compose
```

## Setup Folder Structure

The project expects a specific folder structure in order for the docker environment to locate local source code during development.

```bash
cd ~
mkdir -p contestsite/django
mkdir -p contestsite/docker
```

## Clone the Repositories

Next, clone the repositories for the django and docker application.

```bash
git clone https://github.com/leanrobot/contestsite contestsite/django
git clone https://github.com/leanrobot/contestsite-docker contestsite/docker
```

# Configuring the DB

Now that our application source is downloaded, we need to start the docker container and configure the database for first boot.

## Entering the Dev Environment

```bash
cd ~/contestsite/docker
sudo ./bash.sh # a helper script which will launch the env in interactive mode.
```
This will trigger the docker environments to build for the first time. The process is automated, and will take several minutes. 

Once it is complete you should be at a terminal with the following prompt `root@c63fe097b61c:~# _` where the hash is variable. Subsequent runs will not require rebuilds unless the docker environment is modified.

## Creating DB Tables
```bash
./manage.py syncdb
```

You will be asked to create a superuser, choose yes and follow the prompts.

## ContestSettings Singleton

The site requires the creation of a singleton object currently. In the future this will be configured through the web interface on first visit, but for now it must be done through the python terminal.

Enter the interactive python terminal: `./manage.py shell`
```python
>>> from control.models import ContestSettings # run on refactor branch
>>> from team.models import ContestSettings # run on master branch
>>> from datetime import datetime, timedelta
>>> ContestSettings(startTime=datetime.now(), endTime=datetime.now()+timedelta(weeks=4), paused=False).save()
>>> ^d
```

cntrl-d will exit the python terminal.

## Running Site for Development

The site can be run using the local application source code with the following commands (on port 80):

- Interactive bash environment: `sudo ./bash.sh`
  - running the webserver: `./manage.py runserver 0.0.0.0:80`
  - Please see the manage.py documentation for a full explanation of available commands: https://docs.djangoproject.com/en/1.6/ref/django-admin/
- Non-interactive webserver: `sudo ./run_dev.sh`
  - runs a production setup, with the exception that local application source and DB are linked in, instead of the HEAD of the master branch on the github repository.

## Accessing the Django Admin Interface

The admin interface is located at /admin/. You must login with a superuser or staff account.

Currently the admin interface is used to configure all contest settings. It is very similar to the phpMyAdmin interface.
