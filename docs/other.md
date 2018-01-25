# Other

## Docker

Docker is an open platform for developers and sysadmins to build, ship, and run distributed applications.

Offical documentation

* [Docker](https://docs.docker.com)

### Basic Docker commands

TODO
```bash
TODO
```

### Docker Machine

TODO
```bash
TODO
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
