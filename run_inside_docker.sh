#!/bin/bash -x

if [[ -z $1 ]]; then
    echo "usage: $0 <registry>"
    exit 1
fi 

docker build -t docker_clean .
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock:rw --name docker_cleaner docker_clean ./docker_clean -r $1
