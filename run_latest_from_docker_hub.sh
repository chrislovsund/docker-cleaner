#!/bin/bash -x

DOCKER_IMAGE=chrislovsund/docker-cleaner:latest

docker pull $DOCKER_IMAGE
docker run --privileged -v /var/run/docker.sock:/var/run/docker.sock:rw $DOCKER_IMAGE
