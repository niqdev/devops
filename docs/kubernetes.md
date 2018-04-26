# Kubernetes

> **Kubernetes** is a system for automating deployment, scaling, and management of containerized applications

Documentation

* [Kubernetes](https://kubernetes.io/docs/home/?path=browse)

## Setup

Requirements

* [Minikube](https://github.com/kubernetes/minikube)

Basic
```bash
# verify installation
minikube version
kubectl version

# start local cluster
minikube start

# cluster info
kubectl cluster-info

# nodes info
kubectl get nodes

# deploy demo app
kubectl run kubernetes-bootcamp \
  --image=gcr.io/google-samples/kubernetes-bootcamp:v1 \
  --port=8080

# list deployments
kubectl get deployments

# list pods
kubectl get pods

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
