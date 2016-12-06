# Kubernetes challenge #1:

Setup a testing environment using Vagrant where a simple web application is ran using Docker.

The web application can be anything trivial, but it must store and retrieve some data from a database.

The web application and the database must be running inside of dedicated Docker images.

The Docker images must be orchestrated by an orchestration solution of your choice (e.g.: Swarm, Kubernetes, Mesos).

Please attach also a description of the testing environment.

## rails_app

An example Ruby on Rails application for tracking user sessions and uses a
database to save these data.
[Docker image](https://hub.docker.com/r/ryanfox1985/kubernetes_rails_app)

![alt text](https://github.com/ryanfox1985/kubernetes_example/raw/master/rails_app/screenshot_app.png "Image1")


## 1- Kubernetes setup

Setting up a cluster is as simple as running:

    export KUBERNETES_PROVIDER=vagrant
    curl -sS https://get.k8s.io | bash

### Get cluster info
    ./kubernetes/cluster/kubectl.sh cluster-info

### Get nodes
    ./kubernetes/cluster/kubectl.sh get nodes

## 2- Kubernetes run services
    # Load secrets
    ./kubernetes/cluster/kubectl.sh create -f ./secrets.yml

    # Check secrets
    ./kubernetes/cluster/kubectl.sh get secret mysecrets -o yaml

    # Deploy db
    ./kubernetes/cluster/kubectl.sh create -f ./db-deployment.yml

    # Deploy web
    ./kubernetes/cluster/kubectl.sh create -f ./web-deployment.yml

## 3- Check pods
    ./kubernetes/cluster/kubectl.sh get pods

    # Get myapp POD name and initialize the database
    ./kubernetes/cluster/kubectl.sh exec POD_NAME rake db:setup
    ./kubernetes/cluster/kubectl.sh exec POD_NAME rake db:migrate

    curl http://10.245.1.3

## Demo

![alt text](https://github.com/ryanfox1985/kubernetes_example/raw/master/example.gif "Example")    
