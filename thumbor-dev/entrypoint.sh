#!/bin/bash

# Sets "localhost" to the docker host's IP address (only works on systems which set host.docker.internal)
# This is necessary for thumbor to load the images our application uses in development mode as all of them
# are on localhost themselves.
tail -n +2 /etc/hosts > hosts.bak
getent hosts host.docker.internal | awk '{ print $1 " localhost" }' | tee /etc/hosts
cat hosts.bak | tee -a /etc/hosts

# Start thumbor in single mode
/bin/sh /docker-entrypoint.sh thumbor
