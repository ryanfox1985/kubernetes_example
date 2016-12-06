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

## 4- Test the rails application

    curl http://10.245.1.3

    <!DOCTYPE html>
    <html>
      <head>
        <title>RailsApp</title>
        <meta name="csrf-param" content="authenticity_token" />
    <meta name="csrf-token" content="M1l98kPJav+GtZ9C8t/dvQ0M1M098dBP70OuYzi6LsVyR+pWSTgYa7LuVmPa2/Z8P4eUR9jyBljBQV26g43c1g==" />

        <link rel="stylesheet" media="all" href="/assets/application-e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855.css" data-turbolinks-track="reload" />
        <script src="/assets/application-b3edc5aec5355a45cf23578ab9e7e8646299185c79c1636dc1d69a4c1d6f4ae5.js" data-turbolinks-track="reload"></script>
      </head>

      <body>

    <h2>Example app:</h2>

    Visits counter: 1

    <h2>Last 1 visits:</h2>
    <table>
      <tr>
        <td><strong>Token</strong></td>
        <td><strong>User agent</strong></td>
        <td><strong>Started at</strong></td>
        <td><strong>Events</strong></td>
      </tr>

        <tr>
          <td>73469e10-a428-45d4-9ce0-028d92a1fc7a</td>
          <td>Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.98 Safari/537.36</td>
          <td>2016-12-06 09:01:48 UTC</td>
          <td>6</td>
        </tr>
    </table>

      </body>
    </html>


## Demo

![alt text](https://github.com/ryanfox1985/kubernetes_example/raw/master/example.gif "Example")    
