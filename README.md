# JHipster AKS Demo

Pre-requisite: The JHipster microservices docker images have been built and pushed to a docker registry (in our case docker hub).

## Setup your cluster

Login to Azure with the CLI:

    az login

    az group create --name jhipsterCluster --location westeurope

    az aks create --resource-group jhipsterCluster --name jhipsterCluster --node-count 2 --generate-ssh-keys

Wait about 20 min ;-)

Configure your kubectl:

    az aks get-credentials --resource-group jhipsterCluster --name jhipsterCluster

See your cluster:

    ➜  aks-jhipster-demo kubectl get node
    NAME                       STATUS    ROLES     AGE       VERSION
    aks-nodepool1-18273874-0   Ready     agent     32m       v1.9.9
    aks-nodepool1-18273874-1   Ready     agent     32m       v1.9.9

## Deploy to AKS

Run the JHipster kubernetes generator:

    jhipster kubernetes

```
➜  jhipster kubernetes
Using JHipster version installed globally
Executing jhipster:kubernetes
Options: from-cli: true
⎈ Welcome to the JHipster Kubernetes Generator ⎈
Files will be generated in folder: /private/tmp/demo
✔ Docker is installed
? Which *type* of application would you like to deploy? Microservice application
? Enter the root directory where your gateway(s) and microservices are located **/Users/me/path/to/microservice/repositories/**
? Which applications do you want to include in your configuration? accountancy, crm, store
? Do you want to setup monitoring for your applications ? **No**
? Which applications do you want to use with clustered databases (only available with MongoDB and Couchbase)? **No**
JHipster registry detected as the service discovery and configuration provider used by your apps
? Enter the admin password used to secure the JHipster Registry **admin**
? What should we use for the Kubernetes namespace? **default**
? What should we use for the base Docker repository name? **pbesson**
? What command should we use for push Docker image to repository? **docker push**
? Do you want to configure Istio? **Not required**
? Choose the kubernetes service type for your edge services **LoadBalancer - Let a kubernetes cloud provider automatically assign an IP**

Checking Docker images in applications directories...
   create accountancy/accountancy-deployment.yml
   create accountancy/accountancy-service.yml
   create accountancy/accountancy-mongodb.yml
   create crm/crm-deployment.yml
   create crm/crm-service.yml
   create crm/crm-postgresql.yml
   create crm/crm-elasticsearch.yml
   create store/store-deployment.yml
   create store/store-service.yml
   create store/store-mysql.yml
   create README.md
   create registry/jhipster-registry.yml
   create registry/application-configmap.yml
   create kubectl-apply.sh

Kubernetes configuration successfully generated!
```

Deploy your stack in one command

    ./kubectl-apply.sh

See it being deployed live

    watch kubectl get pod

# Scale your architecture

Scale your cluster with:

    az aks scale --name jhipsterCluster --resource-group jhipsterCluster --node-count 3

Scale your apps:

    kubectl scale --replicas=2 deployment/crm

# Clean everything

    az group delete --name jhipsterCluster --yes --no-wait