# GoCD.io

### Info:

This template creates one GoCD server and scale out the number of GoCD agent you need.

The GoCD agent is link with docker engine container as sidekick, so the idea is to not create GoCD agent per language but use docker container to build and test your stuff.
You can use on GoCD agent:
- docker cli
- docker-compose cli
- rancher-compose cli
- make


### Usage:

Select GoCD from catalog.

Choose if you should deploy GoCD Server, or GoCD Agent or the two.
Enter the number of GoCD agent you need.
Choose the key to autoregister GoCD agent.

Click deploy.

GoCD server can now be accessed over the Rancher network on port `8153` (http://IP_CONTAINER:8153). To access from external Rancher network, you need to set load balancer or expose the port 8153.
 


### Source, bugs and enhances

 If you found bugs or need enhance, you can open ticket on github:
 - [GoCD official core project](https://github.com/gocd/gocd)
 - [GoCD Server docker image](https://github.com/disaster37/alpine-gocd-server)
 - [GoCD Agent docker image](https://github.com/disaster37/alpine-gocd-agent)
 - [Rancher Cattle metadata docker image](https://github.com/disaster37/rancher-cattle-metadata)