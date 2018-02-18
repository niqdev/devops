# Other

## Docker

Docker is an open platform for developers and sysadmins to build, ship, and run distributed applications.

Offical documentation

* [Docker](https://docs.docker.com)

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

# temporary container
docker run --rm --name phusion phusion/baseimage:latest
# access container from another shell
docker exec -it phusion bash
```

Build `devops/base` image
```bash
# change path
cd devops-lab/base
# build image
docker build -t devops/base .

# temporary container
docker run --rm --name devops-base devops/base
# access container
docker exec -it devops-base bash
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

## Vagrant

Vagrant is a tool for building and managing virtual machine environments in a single workflow.

Offical documentation

* [Vagrant](https://www.vagrantup.com/docs)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

### Basic Vagrant commands

Setup project creating a Vagrantfile
```bash
vagrant init
```

Boot and connect to the default virtual machine
```bash
vagrant up
vagrant status
vagrant ssh
```

Useful commands
```bash
# shut down gracefully
vagrant halt

# reload (halt + up) + re-provision
vagrant reload --provision

# update box
vagrant box update

# delete virtual machine without prompt
vagrant destory -f
```

## MkDocs

MkDocs is a static site generator.

Offical documentation

* [MkDocs](http://www.mkdocs.org)

### Basic MkDocs commands

Install
```bash
pip install mkdocs
```

Setup in current directory
```bash
mkdocs new .
```

Start dev server with hot reload on [http://127.0.0.1:8000](http://127.0.0.1:8000)
```bash
mkdocs serve
```

Build static site
```bash
mkdocs build --clean
```

Deploy to github
```bash
mkdocs gh-deploy
```

## SDKMAN!

SDKMAN! is a tool for managing parallel versions of multiple Software Development Kits on most Unix based systems.

Offical documentation

* [SDKMAN!](http://sdkman.io)

Setup
```
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk version
```

### Gradle

Setup
```bash
sdk list gradle
sdk install gradle 4.4.1
gradle -version
```

Create Gradle project
```bash
mkdir -p PROJECT_NAME && cd $_
gradle init --type java-library

./gradlew clean build
```

## Books

* [Designing Data-Intensive Applications](http://dataintensive.net) (2017) by Martin Kleppmann
* [Hadoop: The Definitive Guide](http://shop.oreilly.com/product/0636920033448.do) (4th)(2015) by Tom White
* [Spark in Action](https://www.manning.com/books/spark-in-action) (2016) by Petar Zečević and Marko Bonaći
* [Cassandra: The Definitive Guide](http://shop.oreilly.com/product/0636920043041.do) (4th)(2016) By Eben Hewitt, Jeff Carpenter
* [Kafka: The Definitive Guide](http://shop.oreilly.com/product/0636920044123.do) (2017) By Gwen Shapira, Neha Narkhede, Todd Palino
