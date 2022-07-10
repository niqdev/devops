# DevOps

[![github-pages](https://github.com/niqdev/devops/actions/workflows/gh-pages.yml/badge.svg)](https://github.com/niqdev/devops/actions/workflows/gh-pages.yml)

A collection of resources, scripts, docker images, tools and documentation mainly related to distributed systems for local development, learning purposes and quick prototyping.

* [Linux](https://niqdev.github.io/devops/linux)
* [Docker](https://niqdev.github.io/devops/docker) 
* [Ansible](https://niqdev.github.io/devops/ansible)
* [Cassandra](https://niqdev.github.io/devops/cassandra)
* [ZooKeeper](https://niqdev.github.io/devops/zookeeper)
* [Kafka](https://niqdev.github.io/devops/kafka)
* [Hadoop](https://niqdev.github.io/devops/hadoop)
  * [HDFS and MapReduce](https://niqdev.github.io/devops/hadoop/#hdfs-and-mapreduce)
  * [Spark](https://niqdev.github.io/devops/hadoop/#spark)
  * [Zeppelin](https://niqdev.github.io/devops/hadoop/#zeppelin)
  * [Oozie](https://niqdev.github.io/devops/hadoop/#oozie)
* [Kubernetes](https://niqdev.github.io/devops/kubernetes)
* [System Design](https://niqdev.github.io/devops/system-design)
* [Other Resources](https://niqdev.github.io/devops/other-resources)
* [Toolbox](https://niqdev.github.io/devops/toolbox)

## Development

Ubuntu

```bash
# install pip3
sudo apt install -y python3-pip

# install virtualenv globally 
sudo pip3 install virtualenv

# create virtualenv
virtualenv -p $(which python3) venv

# how-to activate virtualenv
source venv/bin/activate

# verify virtualenv
which python
python --version

# how-to deactivate virtualenv
deactivate

# install new package
pip install mkdocs

# update requirements
pip freeze > requirements.txt

# run locally
# http://localhost:8000
mkdocs serve
```
