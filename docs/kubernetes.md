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
