# schema-registry

```bash
cd ansible

# setup
./setup_share.sh
vagrant up

# setup docker
vagrant ssh ansible
ansible-playbook /ansible/site.yml -t docker

# (local) copy docker compose manually
cp data/roles/schema-registry/docker-compose-local.yml .share/node-1/docker-compose-local.yml

vagrant ssh node-1
# update hosts
echo -e "# docker images\n127.0.1.1 zookeeper\n127.0.1.1 kafka\n" | sudo tee -a /etc/hosts
# start docker
sudo -i -u docker
docker-compose -f /data/docker-compose-local.yml up

# setup schema registry
vagrant ssh ansible
ansible-playbook /ansible/site.yml -t schema-registry

# verify schema registry
vagrant ssh node-1
sudo systemctl start confluent-schema-registry
sudo systemctl status confluent-schema-registry
sudo journalctl -u confluent-schema-registry -b
sudo journalctl -ru confluent-schema-registry --no-pager
ll /etc/schema-registry/
ll /var/log/confluent/schema-registry/
ll /home/cp-schema-registry/logs/
less +G /var/log/confluent/schema-registry/schema-registry.log
tail -F /var/log/confluent/schema-registry/schema-registry.log

# (local) examples
http -v 192.168.100.11:8081/subjects

# check running services
sudo netstat -ltp

# check user
ps -ef | grep schema
cat /etc/passwd

# verify zookeeper
docker exec -it my-local-zookeeper bash
zkCli.sh
get /brokers/ids/0
```
