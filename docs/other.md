## Online tools

* [Regular Expressions](https://regexr.com)
* [Regular Expression Visualization Site](https://regexper.com)
* [Current Millis](https://currentmillis.com)
* [JSFiddle](https://jsfiddle.net)
* [ScalaFiddle](https://scalafiddle.io)
* [JSON Formatter](https://jsonformatter.curiousconcept.com)
* [Beautify JavaScript or HTML](http://jsbeautifier.org)
* [devdocs](https://devdocs.io)

<br>

## Vagrant

> **Vagrant** is a tool for building and managing virtual machine environments in a single workflow

Resources

* [Documentation](https://www.vagrantup.com/docs)
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
vagrant box list

# delete virtual machine without prompt
vagrant destory -f
```

<br>

## MkDocs

> **MkDocs** is a static site generator

Resources

* [Documentation](http://www.mkdocs.org)

Install
```bash
pip install mkdocs
sudo -H pip3 install mkdocs
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

Resources

* [Documentation](http://sdkman.io)

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

Resources

* [Documentation](http://www.foundweekends.org/giter8)
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

## Snap

Resources

* [Documentation](https://docs.snapcraft.io)

Useful commands
```bash
# search
snap find gimp

# info
snap info gimp

# install
snap install gimp

# list installed app
snap list
```

<br>

## Python

Resources

* [pip](https://pip.pypa.io/en/stable/user_guide)
* [virtualenv](https://virtualenv.pypa.io/en/stable/userguide)
* [What is the difference between virtualenv | pyenv | virtualenvwrapper | venv ?](https://stackoverflow.com/questions/41573587/what-is-the-difference-between-venv-pyvenv-pyenv-virtualenv-virtualenvwrappe/41573588#41573588)

Setup
```bash
# search
apt-get update && apt-cache search python | grep python2

# setup python
apt-get install -y python2.7
apt-get install -y python3

# install pip + setuptools
curl https://bootstrap.pypa.io/get-pip.py | python2.7 -
curl https://bootstrap.pypa.io/get-pip.py | python3 -
apt install -y python-pip
apt install -y python3-pip

# upgrade pip
pip install -U pip

# install virtualenv globally 
pip install virtualenv
```

virtualenv
```bash
# create virtualenv
virtualenv venv
virtualenv -p python3 venv
virtualenv -p $(which python3) venv

# activate virtualenv
source venv/bin/activate

# verify virtualenv
which python
python --version

# deactivate virtualenv
deactivate
```

pip
```bash
# search package
pip search <package>

# install new package
pip install <package>

# update requirements with new packages
pip freeze > requirements.txt

# install all requirements
pip install -r requirements.txt
```

Other
```bash
# generate rc file
pylint --generate-rcfile > .pylintrc

# create module
touch app/{__init__,main}.py
```

<br>

## Git

Resources

* [git - the simple guide](https://rogerdudler.github.io/git-guide)
* [git notes (1)](https://github.com/niqdev/git-notes/blob/master/git-real-1.md)
* [git notes (2)](https://github.com/niqdev/git-notes/blob/master/git-real-2.md)

<br>

## Mercurial

Resources

* [A Guide to Branching in Mercurial](http://stevelosh.com/blog/2009/08/a-guide-to-branching-in-mercurial)

```bash
# changes since last commit
hg st

# verify current branch
hg branch

# lists all branches
hg branches

# checkout default branch
hg up default

# pull latest changes
hg pull -u

# create new branch
hg branch "branch-name"

# track new file
hg add .

# track new files and untrack removed files
hg addremove

# commit all tracked files
hg commit -m "my-comment"

# commit specific files
hg commit FILE_1 FILE_2 -m "my-comment"

# commit and track/untrack files (i.e. addremove)
hg commit -A -m "my-comment-with-addremove"

# rename last unpushed commit message
hg commit -m "bad-commit-message"
hg commit --amend -m "good-commit-message"

# discard untracked files
hg purge

# discard uncommitted local changes
hg up -C

# discard local uncommitted branch
hg strip "branch-name"

# push commits in all branches
hg push

# push commits in current branch
hg push -b .

# create a new branch and push commits in current branch (first time only)
hg push -b . --new-branch

# lists unpushed commit
hg outgoing

# change head to specific revision
hg up -r 12345

# merge default branch on current branch
hg up default
hg pull -u
hg status
hg up CURRENT-BRANCH
hg merge default
hg diff

# remove all resolved conflicts
rm **/*.orig

# list stashes
hg shelve --list

# stash
hg shelve -n "my-draft"

# unstash
hg unshelve "my-draft"

# revert/undo last unpushed commit
hg strip -r -1 --keep
hg strip --keep --rev .

# solve conflicts manually and then mark it as merged
hg resolve -m FILE-NAME

# lists commits
hg log
hg ls

# pretty log
hg history --graph --limit 10
```

<br>
