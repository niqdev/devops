## Ansible

Requirements

* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](https://www.vagrantup.com/downloads.html)
* [Ansible](http://docs.ansible.com/ansible/latest/index.html)

```
vagrant ssh ansible

# ping all nodes (default inventory /etc/ansible/hosts)
ansible all -m ping

# specify inventory
ansible all -i "/vagrant/data/hosts" -m ping

# specify host and user
ansible ip-192-168-100-11.local -m ping -u vagrant

# execute command
ansible all -a "/bin/echo hello"
ansible all -a "uptime"

# shell module
ansible all -m shell -a "pwd"
# be carefull to quotes
ansible all -m shell -a 'echo $HOME'
```
