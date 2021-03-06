# docker-cleaner
Small ruby script to remove containers and images not running or being used.

Can be run in ruby environment or use bash script to run inside [docker image ruby:2.1-onbuild](https://registry.hub.docker.com/_/ruby/) (inspired by [meltwater/docker-cleanup](https://github.com/meltwater/docker-cleanup)).

### Command Line
```
docker run --privileged \
  -v /var/run/docker.sock:/var/run/docker.sock:rw \
  chrislovsund/docker-cleaner:latest
```

### Command Line with custom config
*config.json* file that have to located in folder *config* in example below.
```
docker run --privileged \
  -v /var/run/docker.sock:/var/run/docker.sock:rw \
  -v `readlink -f config`:/usr/src/app/config:ro \
  chrislovsund/docker-cleaner:latest
```
