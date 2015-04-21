# docker-cleaner
Small ruby script to remove containers and images older than one week.

Can be run in ruby environment or use bash script to run inside [docker image ruby:2.1-onbuild](https://registry.hub.docker.com/_/ruby/) (inspired by [meltwater/docker-cleanup](https://github.com/meltwater/docker-cleanup)).

### Command Line
```
docker run --privileged \
  -v /var/run/docker.sock:/var/run/docker.sock:rw \
  chrislovsund/docker-cleaner:latest
```
