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

Scala
```bash
# setup sbt
sdk list sbt
sdk install sbt
sbt sbtVersion
sbt about

# setup scala
sdk list scala
sdk install scala 2.11.8
scala -version

# sample project
sbt new sbt/scala-seed.g8
```

<br>

## Giter8

> **Giter8** is a command line tool to generate files and directories from templates published on GitHub or any other git repository

Documentation

* [Giter8](http://www.foundweekends.org/giter8)
* [Templates](https://github.com/foundweekends/giter8/wiki/giter8-templates)

Setup
```bash
# install conscript
curl https://raw.githubusercontent.com/foundweekends/conscript/master/setup.sh | sh
source ~/.bashrc

# install g8
cs foundweekends/giter8
```

Example
```bash
# interactive
g8 sbt/scala-seed.g8
# non-interactive
g8 sbt/scala-seed.g8 --name=my-new-website
```

<br>

## Python

Documentation

* [pip](https://pip.pypa.io/en/stable/user_guide)
* [virtualenv](https://virtualenv.pypa.io/en/stable/userguide)
* [virtualenvwrapper](https://virtualenvwrapper.readthedocs.io/en/latest/index.html)
* [venv](https://docs.python.org/3/library/venv.html)

### virtualenv
```bash
# install pip + setuptools
curl https://bootstrap.pypa.io/get-pip.py | python -

# upgrade pip
pip install -U pip

# install virtualenv globally 
sudo pip install virtualenv

# create virtualenv
virtualenv env
virtualenv -p python3 env
virtualenv -p $(which python3) env

# activate virtualenv
source env/bin/activate

# verify virtualenv
which python
python --version

# deactivate virtualenv
deactivate
```

### pip
```bash
# search package
pip search <package>

# install new package
pip install <package>

# update requirements with new package
pip freeze > requirements.txt

# install all requirements
pip install -r requirements.txt
```

### Other
```bash
# generate rc file
pylint --generate-rcfile > .pylintrc

# create module
touch app/{__init__,main}.py
```

<br>

## Further reading

* [How Linux Works](https://nostarch.com/howlinuxworks2) (2014)(2nd) by Brian Ward
* [Docker in Action](https://www.manning.com/books/docker-in-action) (2016) by Jeff Nickoloff
* [Designing Data-Intensive Applications](http://dataintensive.net) (2017) by Martin Kleppmann
* [Hadoop: The Definitive Guide](http://shop.oreilly.com/product/0636920033448.do) (2015)(4th) by Tom White
* [Spark in Action](https://www.manning.com/books/spark-in-action) (2016) by Petar Zečević and Marko Bonaći
* [Cassandra: The Definitive Guide](http://shop.oreilly.com/product/0636920043041.do) (2016)(4th) by Eben Hewitt, Jeff Carpenter
* [Kafka: The Definitive Guide](http://shop.oreilly.com/product/0636920044123.do) (2017) by Gwen Shapira, Neha Narkhede, Todd Palino

Scala

* [Programming in Scala](https://www.artima.com/shop/programming_in_scala) (2016)(3rd) by Martin Odersky, Lex Spoon, and Bill Venners
* [Functional Programming in Scala](https://www.manning.com/books/functional-programming-in-scala) (2014) by Paul Chiusano and Runar Bjarnason
* [Akka in Action](https://www.manning.com/books/akka-in-action) (2016) by Raymond Roestenburg, Rob Bakker, and Rob Williams

<br>
