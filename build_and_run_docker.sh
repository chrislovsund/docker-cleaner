#!/bin/bash -x

DOCKER_IMAGE=docker-cleaner-image
DOCKER_CONTAINER=docker-cleaner

docker rm $DOCKER_CONTAINER
docker build -t $DOCKER_IMAGE .
docker run -i --rm -v /var/run/docker.sock:/var/run/docker.sock:rw -v `readlink -f config`:/usr/src/app/config:ro --name $DOCKER_CONTAINER $DOCKER_IMAGE
