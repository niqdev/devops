## Ansible

Documentation

* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](https://www.vagrantup.com/downloads.html)
* [Ansible](http://docs.ansible.com/ansible/latest/index.html)

```
vagrant up
vagrant ssh ansible

# ping all nodes (default inventory /etc/ansible/hosts)
ansible all -m ping
ansible ansible -m ping
ansible cluster -m ping

# gathering facts
ansible all -m setup
ansible ansible -m setup

# specify inventory
ansible all -i "/vagrant/data/hosts" -m ping

# specify host and user
ansible ip-192-168-100-11.local -m ping -u vagrant

# execute command
ansible all -a "/bin/echo hello"
ansible all -a "uptime"
ansible all -a "/bin/date"
# NEVER reboot vagrant with ansible
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

# playbook
ansible-playbook /ansible/site.yml
# dry run
ansible-playbook -i /ansible/hosts /ansible/site.yml --verbose --check --diff
```

# TODO java
https://gist.github.com/andershedstrom/7c7d0bb5b9450c54a907
https://github.com/vrischmann/ansible-role-java/blob/master/tasks/main.yml
https://github.com/deveth0/ansible-oracle-java/blob/master/tasks/main.yml

# TODO use tags
-- tags
