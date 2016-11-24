## Prerequisites

* Port `2377` and `2378` must be open
* Docker v1.12.1 installed

SwarmKit's overlay network configuration must determine which interface will be used for cross-host communication. By default, Rancher routes traffic over public IP addresses. Swarm can't always detect the corresponding interface; you may need to do one of the following:

* Register hosts with CATTLE_AGENT_IP environment variable set to a system address
* Specify the host interface for Swarm to listen on (hosts must have the same interface name)

## Features

* Automatically scale up/down a Swarm by adding/removing hosts to an environment
  * Do not attempt to run `docker swarm` commands manually
* Configurable number of managers tunable to desired [failure tolerance](https://docs.docker.com/engine/swarm/admin_guide/#/add-manager-nodes-for-fault-tolerance)
* Reconciliation logic promotes/demotes managers/workers to maintain resilience

## Limitations

* Swarm over public networks is not supported in Docker 1.12.3 and older