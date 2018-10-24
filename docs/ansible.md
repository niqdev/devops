# Ansible

> **Ansible** is an open source automation platform that can help with config management, deployment and task automation

Resources

* [Documentation](http://docs.ansible.com/ansible/latest/index.html)

* [Ansible - Up and Running](https://amzn.to/2IDtDSd) (2017) by Lorin Hochstein and Rene Moser (Book)

* [Tutorial](https://serversforhackers.com/c/an-ansible2-tutorial)

* [Playbook example](https://gist.github.com/marktheunissen/2979474)

The following guide explains how to provision Ansible locally and play with it. Checkout the [Vagrantfile](https://github.com/niqdev/devops/blob/master/ansible/Vagrantfile) and the Vagrant [guide](other/#vagrant) for more details.

### Setup

Requirements

* [Vagrant 2](https://www.vagrantup.com)
* [VirtualBox 5](https://www.virtualbox.org)

Directory structure
```bash
tree -a ansible/
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
│   │   │   │   ├── oracle-jdk.yml
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
├── destroy_ansible.sh
├── setup_ansible.sh
└── setup_share.sh
```

The first time *only*, you have to setup the shared folders and generate the ssh key needed by ansible to access all nodes executing

```bash
./setup_share.sh
```

Start the boxes with
```bash
vagrant up
```
*The first time it could take a while*

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
* `/ansible` data *(ansible only)*
* `/data` .share *(node only)*

Cleanup
```bash
./destroy_ansible.sh
```

## Ad-Hoc Commands

Access the ansible box with
```bash
vagrant ssh ansible
```

Below a list of examples
```bash

# ping all nodes (default inventory /etc/ansible/hosts)
ansible all -m ping
ansible ansible -m ping
ansible cluster -m ping

# ping all nodes (specify inventory)
ansible all -i "/vagrant/data/hosts" -m ping

# gathering facts
ansible all -m setup
ansible ansible -m setup

# specify host and user
ansible ip-192-168-100-11.local -m ping -u vagrant

# execute command
ansible all -a "/bin/echo hello"
ansible all -a "uptime"
ansible all -a "/bin/date"
# do NOT reboot vagrant through ansible (use vagrant reload)
ansible cluster -a "/sbin/reboot" --become

# shell module
ansible all -m shell -a "pwd"
# be carefull to quotes
ansible all -m shell -a 'echo $HOME'

# update && upgrade
ansible all -m apt -a "update_cache=yes upgrade=dist" --become
# restart after upgrade
vagrant reload
# install package
ansible all -m apt -a "name=tree state=present" --become
```

## Playbooks

Access the ansible box with
```bash
vagrant ssh ansible
```

Below a list of examples

```bash
# test uptime on all node
ansible-playbook /ansible/site.yml --tags=test --verbose

# update & upgrade only on cluster nodes
ansible-playbook /ansible/site.yml -t package --skip-tags=oracle-jdk --verbose

# install oracle-jdk only on cluster nodes
ansible-playbook /ansible/site.yml -t oracle-jdk

# install all packages on cluster nodes
ansible-playbook /ansible/site.yml -t package --verbose

# run common task on cluster node
ansible-playbook /ansible/site.yml -t common

# setup docker
ansible-playbook /ansible/site.yml -t docker
# test docker
vagrant ssh node-1
sudo -i -u docker
docker ps -a

# custom banner
ansible-playbook /ansible/site.yml -t motd

# setup all infrastructure at once
ansible-playbook /ansible/site.yml

# dry run
ansible-playbook -i /ansible/hosts /ansible/site.yml --check --diff
```

<br>
