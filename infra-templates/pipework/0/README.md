# Pipework

*Software-Defined Networking for Linux Containers*

## Description

* GitHub: [jpetazzo/pipework](https://github.com/jpetazzo/pipework)
* Docker Hub: [dreamcat4/pipework](https://hub.docker.com/r/dreamcat4/pipework/)

By this catalog, to configure more flexible container network is available.  
A good example of this, there is multiple container networks.

## Deployment

1. Select the template from the catalog.
2. Click `Launch`.

## Usage

To deploy a container having two NICs as an example, deploy it by the following steps.

1. Create *Stack*.
    * Already created *Stack* is available.
2. Create *Service*.
    * Already created *Service* is available.
3. Set *Environment*.
    * pipework_cmd_0: eth0 -i eth0 @CONTAINER_NAME@ 192.168.1.101/24 02:42:c0:a8:01:65@100
    * pipework_cmd_1: eth1 -i eth0 @CONTAINER_NAME@ 192.168.2.101/24 02:42:c0:a8:02:65@200

You can see the more details from [dreamcat4/pipework](https://github.com/dreamcat4/docker-images/tree/master/pipework).