## Prerequisites

* Docker 1.13 or later
* Port `2377` and `2378` must be open

## Features

* Automatically scale up/down a Swarm by adding/removing hosts to/from an environment
  * Please do not attempt to run `docker swarm` commands manually
* Configurable number of managers tunable to desired [fault tolerance](https://docs.docker.com/engine/swarm/admin_guide/#/add-manager-nodes-for-fault-tolerance)
  * Reconciliation promotes/demotes managers/workers to maintain fault tolerance

