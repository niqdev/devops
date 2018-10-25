# schema-registry

```bash
cd ansible

# setup
./setup_share.sh
vagrant up

# setup docker
vagrant ssh ansible
ansible-playbook /ansible/site.yml -t docker

# copy docker compose manually
cp data/roles/schema-registry/docker-compose-kafka.yml .share/node-1/docker-compose-kafka.yml

# start docker
vagrant ssh node-1
sudo -i -u docker
docker-compose -f /data/docker-compose-kafka.yml up
# update hosts
echo -e "# docker images\n127.0.1.1 zookeeper\n127.0.1.1 kafka\n" | sudo tee -a /etc/hosts

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
ll /home/confluent/logs/schema-registry/
less +G /var/log/confluent/schema-registry/schema-registry.log
tail -F /var/log/confluent/schema-registry/schema-registry.log
http 192.168.100.11:8081

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
