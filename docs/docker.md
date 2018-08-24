# Docker

> **Docker** is an open platform for developers and sysadmins to build, ship, and run distributed applications

Resources

* [Documentation](https://docs.docker.com)

* [Docker in Action](https://amzn.to/2MxbJTt) (2016) by Jeff Nickoloff (Book)

## How-To

Setup
```bash
# install docker
curl -fsSL get.docker.com -o get-docker.sh && \
  chmod u+x $_ && \
  ./$_ && \
  sudo usermod -aG docker hadoop

docker --version

# install docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` \
  -o /usr/local/bin/docker-compose && \
  sudo chmod +x /usr/local/bin/docker-compose

docker-compose --version

# install docker-machine (VirtualBox required)
curl -L https://github.com/docker/machine/releases/download/v0.13.0/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine && \
  sudo install /tmp/docker-machine /usr/local/bin/docker-machine

docker-machine --version
```

Useful commands
```bash
# list images
docker images
# list containers
docker ps -a
# list volumes
docker volume ls

# run temporary container
docker run --rm --name phusion phusion/baseimage:latest
# access container from another shell
docker exec -it phusion bash

# remove container by name
docker ps -a -q -f name=CONTAINER_NAME | xargs --no-run-if-empty docker rm -f
# delete dangling images <none>
docker images -q -f dangling=true | xargs --no-run-if-empty docker rmi
# delete dangling volumes
docker volume ls -q -f dangling=true | xargs --no-run-if-empty docker volume rm
```

Docker Machine
```bash
# create local machine
docker-machine create --driver virtualbox default

# list
docker-machine ls
docker-machine ls --filter name=default
docker-machine ls --filter state=Running
docker-machine ls --format "{{.Name}}: {{.DriverName}} - {{.State}}"

# info
docker-machine inspect default
docker-machine inspect --format='{{.Driver.IPAddress}}' default
docker-machine status default
docker-machine ip default

# management
docker-machine start default
docker-machine stop default
docker-machine restart default
docker-machine rm default

# mount volume
#https://docs.docker.com/machine/reference/mount

# show command to connect to machine
docker-machine env default
# check if variables are set
env | grep DOCKER

# connect to machine
eval "$(docker-machine env default)"
docker ps -a

# show command to disconnect from machine
docker-machine env -u
# unset all
eval $(docker-machine env -u)

# access
docker-machine ssh default
# execute command and exit
docker-machine ssh default uptime
# copy files from host to guest
docker-machine scp -r /FROM default:/TO

# start nginx on default machine
docker run -d -p 8000:80 nginx
# verify from host
curl $(docker-machine ip default):8000
# forward to port 8080
docker-machine ssh default -L 8080:localhost:8000
# verify tunnel from host
curl localhost:8080

# disable error crash reporting
mkdir -p ~/.docker/machine && touch ~/.docker/machine/no-error-report
```

## Base image

* [Supervisor](http://supervisord.org)

Build `devops/base` image
```bash
# change path
cd devops/base

# build image
docker build -t devops/base .

# temporary container
docker run --rm --name devops-base devops/base
# access container
docker exec -it devops-base bash

# configurations
/etc/supervisor/conf.d

# supervisor actions
supervisorctl status
supervisorctl start SERVICE_NAME
supervisorctl stop SERVICE_NAME
```

## Docker Hub

* [niqdev/phusion-base](https://hub.docker.com/r/niqdev/phusion-base)
* [niqdev/zookeeper](https://hub.docker.com/r/niqdev/zookeeper)
* [niqdev/kafka](https://hub.docker.com/r/niqdev/kafka)

```bash
docker login

# phusion-base
# https://github.com/phusion/baseimage-docker
docker build -t devops/base:latest ./base
docker tag devops/base niqdev/phusion-base:0.11
docker tag devops/base niqdev/phusion-base:latest
docker push niqdev/phusion-base:0.11
docker push niqdev/phusion-base:latest

# zookeeper
docker build -t devops/zookeeper:latest ./zookeeper
docker tag devops/zookeeper niqdev/zookeeper:3.4.13
docker tag devops/zookeeper niqdev/zookeeper
docker push niqdev/zookeeper:3.4.13
docker push niqdev/zookeeper:latest

# kafka
docker build -t devops/kafka:latest ./kafka
docker tag devops/kafka niqdev/kafka:2.0.0
docker tag devops/kafka niqdev/kafka
docker push niqdev/kafka:2.0.0
docker push niqdev/kafka:latest

docker-compose -f kafka/docker-compose-hub.yml up
```

<br>
