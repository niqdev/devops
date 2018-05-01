# Kubernetes

> **Kubernetes** is a system for automating deployment, scaling, and management of containerized applications

Documentation

* [Kubernetes](https://kubernetes.io/docs/home/?path=browse)

## Setup

Requirements

* [Minikube](https://github.com/kubernetes/minikube)

Local cluster
```bash
# verify installation
minikube version

# lifecycle
minikube start --vm-driver=virtualbox
minikube stop
minikube delete

# dashboard
export NO_PROXY=localhost,127.0.0.1,$(minikube ip)
minikube dashboard

# access
minikube ssh
docker ps -a

# reuse the minikube's built-in docker daemon
eval $(minikube docker-env)
```

Basic
```bash
# verify installation
kubectl version

# cluster info
kubectl cluster-info
kubectl get nodes
kubectl describe nodes
kubectl config view

# namespace
kubectl create namespace local
kubectl get namespaces
kubectl config set-context $(kubectl config current-context) --namespace=local
kubectl config view | grep namespace
kubectl delete namespace local
```

---

TODO
```bash

# create objects
run
expose
autoscale
# update objects
scale
annotate
label
# delete
delete
# view an object
get
describe
logs

# generate yaml
kubectl create service -o yaml --dry-run

# create deployment object
# imperative commands
kubectl run nginx --image nginx
kubectl create deployment nginx --image nginx

# imperative object configuration
kubectl create -f nginx.yaml
kubectl delete -f nginx.yaml
kubectl replace -f nginx.yaml

# declarative object configuration
kubectl apply -f xxx


# deploy demo app
kubectl run kubernetes-bootcamp \
  --image=gcr.io/google-samples/kubernetes-bootcamp:v1 \
  --port=8080

# update app
kubectl set image deployments/kubernetes-bootcamp \
  kubernetes-bootcamp=jocatalin/kubernetes-bootcamp:v2

# verify update
kubectl rollout status deployments/kubernetes-bootcamp

# undo latest deployment
kubectl rollout undo deployments/kubernetes-bootcamp

# list deployments
kubectl get deployments

# list pods
kubectl get pods
TODO
# filter with equality-based labels
kubectl get pods -l environment=production,tier=frontend
# filter with set-based labels
kubectl get pods -l 'environment in (production),tier in (frontend)'

# list containers inside pods
kubectl describe pods
```

Pod and container
```bash
# proxy cluster (2nd terminal)
kubectl proxy

# pod name
export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
echo Name of the Pod: $POD_NAME

# verify proxy
http :8001/version
http :8001/api/v1/proxy/namespaces/default/pods/$POD_NAME/

# view logs
kubectl logs $POD_NAME

# execute command on the container
kubectl exec $POD_NAME env
kubectl exec $POD_NAME ls -- -la

# access the container
kubectl exec -ti $POD_NAME bash

# delete pod
kubectl delete pod $POD_NAME
```

Services
```bash
# list services
kubectl get services

# create service
kubectl expose deployment/kubernetes-bootcamp \
--type="NodePort" \
--port 8080

# service info
kubectl describe services/kubernetes-bootcamp

# expose service
export NODE_PORT=$(kubectl get services/kubernetes-bootcamp -o go-template='{{(index .spec.ports 0).nodePort}}')
echo NODE_PORT=$NODE_PORT

# verify service
curl $(minikube ip):$NODE_PORT

# deployment info
kubectl describe deployment

# list by label
kubectl get pods -l run=kubernetes-bootcamp
kubectl get services -l run=kubernetes-bootcamp

# apply label
kubectl label pod $POD_NAME app=v1

# verify label
kubectl describe pods $POD_NAME

# query by label
kubectl get pods -l app=v1

# delete service
kubectl delete service -l run=kubernetes-bootcamp
```

Scaling
```bash
# add 4 replicas
kubectl scale deployments/kubernetes-bootcamp --replicas=4

# verify scaling
kubectl get deployments
kubectl get pods -o wide
kubectl describe deployments/kubernetes-bootcamp
```
