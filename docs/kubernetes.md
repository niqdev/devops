# Kubernetes

> **Kubernetes** is a system for automating deployment, scaling, and management of containerized applications

Resources

* [Documentation](https://kubernetes.io/docs/home)

* [Offical Blog](https://kubernetes.io/blog)

* [Kubernetes in Action](https://amzn.to/2yXEGWx) (2017) by Marko Lukša (Book)

* [Kubernetes by Example](http://kubernetesbyexample.com)

* [Kubernetes comic](https://cloud.google.com/kubernetes-engine/kubernetes-comic)

* [Running akka-cluster on Kubernetes](https://blog.softwaremill.com/running-akka-cluster-on-kubernetes-e4cd2913e951)

* [Kubernetes: The Surprisingly Affordable Platform for Personal Projects](http://www.doxsey.net/blog/kubernetes--the-surprisingly-affordable-platform-for-personal-projects)

* [Kubernetes from scratch to AWS with Terraform and Ansible](https://opencredo.com/kubernetes-aws-terraform-ansible-1)

* YouTube channels: [Kubernetes](https://www.youtube.com/channel/UCZ2bu0qutTOM0tHYa_jkIwg) and [Cloud Native Computing Foundation](https://www.youtube.com/channel/UCvqbFHwN-nwalWPjPUKpvTA)

## Architecture

At the hardware level, a Kubernetes cluster node can be

* a *master* node, which hosts the **Kubernetes Control Plane** that manages the state of the cluster
    - The **Kubernetes API Server** to communicate with the cluster
    - The **Scheduler**, which schedules apps (assigns a worker node to each deployable component)
    - The **Controller Manager**, which performs cluster-level functions, such as replicating components, keeping track of worker nodes handling node failures, and so on
    - **etcd**, a reliable distributed data store that persistently stores the cluster configuration
* a *worker* nodes that run containerized applications
    - Docker, rkt, or another **container runtime**, which runs containers
    - The **Kubelet**, which talks to the API server and manages containers on its node
    - The **Kubernetes Service Proxy (kube-proxy)**, which load-balances network traffic between application components

![kubernetes-architecture](img/kubernetes-architecture.png)

* To run an application in Kubernetes, it needs to be packaged into one or more container images, those images need to be pushed to an image registry, and then a description of the app posted to the Kubernetes API Server
* When the API server processes the app's description, the Scheduler schedules the specified groups of containers onto the available worker nodes based on computational resources required by each group and the unallocated resources on each node at that moment
* The Kubelet on those nodes then instructs the Container Runtime (Docker, for example) to pull the required container images and run the containers
* Once the application is running, Kubernetes continuously makes sure that the deployed state of the application always matches the description you provided
* To allow clients to easily find containers that provide a specific service, it's possible to tell Kubernetes which containers provide the same service and Kubernetes will expose all of them at a single static IP address and expose that address to all applications running in the cluster

## Setup

Requirements

* [Minikube](https://github.com/kubernetes/minikube)
* [VirtualBox](https://www.virtualbox.org)

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

Simple deployment
```bash
# deploy demo app
kubectl run kubernetes-bootcamp \
  --image=gcr.io/google-samples/kubernetes-bootcamp:v1 \
  --port=8080 \
  --labels='app=kubernetes-bootcamp'

# update app
kubectl set image deployments/kubernetes-bootcamp \
  kubernetes-bootcamp=jocatalin/kubernetes-bootcamp:v2

# verify update
kubectl rollout status deployments/kubernetes-bootcamp
kubectl rollout history deployments/kubernetes-bootcamp

# undo latest deployment
kubectl rollout undo deployments/kubernetes-bootcamp

# list deployments
kubectl get deployments

# list containers inside pods
kubectl describe pods

# list pods
kubectl get pods

# filter with equality-based labels
kubectl get pods -l app=kubernetes-bootcamp

# filter with set-based labels
kubectl get pods -l 'app in (kubernetes-bootcamp)'
```

Pod and Container
```bash
# proxy cluster (open in 2nd terminal)
kubectl proxy

# pod name
export POD_NAME=$(kubectl get pods -l app=kubernetes-bootcamp -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
echo POD_NAME=$POD_NAME

# verify proxy
http :8001/version
http :8001/api/v1/proxy/namespaces/default/pods/$POD_NAME/

# view logs
kubectl logs $POD_NAME

# execute command on container
kubectl exec $POD_NAME printenv
kubectl exec $POD_NAME ls -- -la

# access container
kubectl exec -it $POD_NAME bash

# verify label
kubectl describe pods $POD_NAME
```

Service
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

# add 4 replicas
kubectl scale deployments/kubernetes-bootcamp --replicas=4

# info
kubectl get pod,deployment,service
kubectl get pods -o wide
kubectl describe deployments/kubernetes-bootcamp

# cleanup
kubectl delete deployment,service kubernetes-bootcamp
```

<br>
