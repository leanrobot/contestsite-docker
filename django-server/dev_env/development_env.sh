#!/bin/bash

sudo apt-get install -yq \
	vim man \
	zsh

chsh -s /bin/zsh

# Copy over the zsh configuration files
cp zshrc ~/.zshrc
cp zshrc_git ~/.zshrc_git