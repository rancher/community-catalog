## Prerequisites

* Docker v1.12.1 to v1.12.3
* Port `2377` and `2378` must be open
* Hosts are registered with `-e CATTLE_AGENT_IP=<private ip>` flag (IP address must be a system address)

## Features

* Automatically scale up/down a Swarm by adding/removing hosts to/from an environment
  * Please do not attempt to run `docker swarm` commands manually
* Configurable number of managers tunable to desired [fault tolerance](https://docs.docker.com/engine/swarm/admin_guide/#/add-manager-nodes-for-fault-tolerance)
  * Reconciliation promotes/demotes managers/workers to maintain fault tolerance

## Limitations

* Swarm over public networks is not supported in Docker 1.12.3 and earlier
