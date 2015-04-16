#!/bin/bash -x

DOCKER_IMAGE=docker_clean
DOCKER_CONTAINER=docker_cleaner

docker rm $DOCKER_CONTAINER
docker build -t $DOCKER_IMAGE .
docker run -i --rm -v /var/run/docker.sock:/var/run/docker.sock:rw --name $DOCKER_CONTAINER $DOCKER_IMAGE ./docker_clean.rb
