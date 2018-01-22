# Ansible

Setup 4 Ubuntu boxes, 1 with Ansible and 3 nodes to run the playbooks against.

Requirements

* Vagrant
* VirtualBox

Official documentations

* [Vagrant](https://www.vagrantup.com/docs)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Ansible](http://docs.ansible.com/ansible/latest/index.html)

For more details about Vagrant please check [here](other.md)

### Directory structure

```
ansible/
├── .share
│   ├── node-1
│   ├── node-2
│   ├── node-3
│   └── ssh
│       ├── ansible_rsa
│       └── ansible_rsa.pub
├── Vagrantfile
├── data
│   ├── group_vars
│   ├── host_vars
│   ├── hosts
│   ├── roles
│   │   ├── common
│   │   │   ├── defaults
│   │   │   ├── files
│   │   │   ├── handlers
│   │   │   ├── meta
│   │   │   ├── tasks
│   │   │   │   ├── main.yml
│   │   │   │   ├── motd.yml
│   │   │   │   └── package.yml
│   │   │   ├── templates
│   │   │   │   └── motd
│   │   │   └── vars
│   │   │       └── main.yml
│   │   └── docker
│   │       ├── meta
│   │       │   └── main.yml
│   │       └── tasks
│   │           └── main.yml
│   └── site.yml
├── setup_ansible.sh
└── setup_share.sh
```

## Setup

The first time only, you need to setup the shared folders and generate the ssh key needed by ansible to access all nodes. Execute:

```
./setup_share.sh
```

From now on start the boxes simply with `vagrant up`. If is the first time go and grab a coffee, it could take a while!

## Ad-Hoc Commands

TODO

## Playbooks

TODO
