#!/bin/bash

# install private server
npm i -g sinopia htpasswd-for-sinopia

# add depend
touch ~/.config/sinopia/htpasswd

# default server
echo 'listen: http://0.0.0.0:54321' >> ~/.config/sinopia/config.yaml