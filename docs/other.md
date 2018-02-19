## Vagrant

> **Vagrant** is a tool for building and managing virtual machine environments in a single workflow

Documentation

* [Vagrant](https://www.vagrantup.com/docs)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

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

<br>

## MkDocs

> **MkDocs** is a static site generator

Documentation

* [MkDocs](http://www.mkdocs.org)

Install
```bash
pip install mkdocs
```

Useful commands
```bash
# setup in current directory
mkdocs new .

# start dev server with hot reload @ http://127.0.0.1:8000
mkdocs serve

# build static site
mkdocs build --clean

# deploy to github
mkdocs gh-deploy
```

<br>

## SDKMAN!

> **SDKMAN!** is a tool for managing parallel versions of multiple Software Development Kits on most Unix based systems

Documentation

* [SDKMAN!](http://sdkman.io)

Setup
```
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk version
```

Gradle
```bash
# setup
sdk list gradle
sdk install gradle 4.4.1
gradle -version

# create Gradle project
mkdir -p PROJECT_NAME && cd $_
gradle init --type java-library

./gradlew clean build
```

<br>

## Further reading

* [How Linux Works](https://nostarch.com/howlinuxworks2) (2014)(2nd) Brian Ward
* [Docker in Action](https://www.manning.com/books/docker-in-action) (2016) Jeff Nickoloff
* [Designing Data-Intensive Applications](http://dataintensive.net) (2017) by Martin Kleppmann
* [Hadoop: The Definitive Guide](http://shop.oreilly.com/product/0636920033448.do) (2015)(4th) by Tom White
* [Spark in Action](https://www.manning.com/books/spark-in-action) (2016) by Petar Zečević and Marko Bonaći
* [Cassandra: The Definitive Guide](http://shop.oreilly.com/product/0636920043041.do) (2016)(4th) By Eben Hewitt, Jeff Carpenter
* [Kafka: The Definitive Guide](http://shop.oreilly.com/product/0636920044123.do) (2017) By Gwen Shapira, Neha Narkhede, Todd Palino

<br>
