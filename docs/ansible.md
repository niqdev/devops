# Ansible

Ansible is an open source automation platform that can help with config management, deployment and task automation.

Documentation

* [Ansible](http://docs.ansible.com/ansible/latest/index.html)
* [Tutorial](https://serversforhackers.com/c/an-ansible2-tutorial)
* [Playbook example](https://github.com/phred/ansible-examples/blob/master/pedantically_commented_playbook.yml)

The following guide explain how to provision Ansible locally and play with it. The current [Vagrantfile](https://github.com/niqdev/provision-tools/blob/master/ansible/Vagrantfile) is configured to setup 4 Ubuntu boxes, 1 with Ansible and 3 nodes to run playbooks against it. Feel free to modify it at your own will.

Requirement

* Vagrant
* VirtualBox

For more details about Vagrant please check [here](other/#vagrant)

## Directory structure

All the commands are executed in this directory `cd ansible`

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

The first time *only*, you have to setup the shared folders and generate the ssh key needed by ansible to access all nodes executing

```bash
./setup_share.sh
```

From now on start the boxes with
```bash
vagrant up
```

*Note that the first time it could take a while*

Verify status of the boxes with
```bash
vagrant status
```

Verify access to the boxes with
```bash
vagrant ssh ansible
vagrant ssh node-1
```

From inside the boxes you should be able to communicate with the others
```bash
ping ansible.local
ping ip-192-168-100-11.local
ping 192.168.100.12
```

The following paths are shared with the boxes

* `/vagrant` provision-tool
* `/local` host $HOME
* `/ansible` data
* `/data` .share

## Ad-Hoc Commands

TODO

## Playbooks

TODO
