# Consul-Registrator

### Info:

This templates creates a global service that deploys a Consul agent that is bound to the host's networking.
This allows all Rancher hosts to join an existing Consul cluster.

Additionally, Registrator is deployed to automatically discover and register containers that are deployed on the host as Consul service entries.
This allows for automatic service registration in Consul as Rancher schedule containers in the cluster.

 The variables used in this template include:

- Hostname or IP address for the Consul cluster to join

The templates uses the official Consul & Registrator images

- [consul](https://hub.docker.com/r/_/consul/).
- [registrator](https://hub.docker.com/r/gliderlabs/registrator/).

### Usage:

 Select Consul from catalog.

 Enter the hostname/DNS name/IP address of the Consul server to join

 Click deploy.
