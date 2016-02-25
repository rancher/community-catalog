# Consul Cluster


### Info:

 This template creates 3 Consul nodes that uses RPC encryption with TLS and gossip encryption to secure connection between consul cluster nodes, configuration is generated with confd from Rancher metadata. 
 TLS is used to verify the authenticity of the servers and the clients using the verify_incoming and verify_outgoing options.

 The variables used in this template include:

- Certificates and keys for Consul nodes.
- CA certificate.
- 16-bytes, Base64 encoded gossip encryption key.
 

The templates uses two Docker images one as the main image and the other one is the sidekick:

- [consul](https://github.com/galal-hussein/consul-rancher).
- [consul-config](https://github.com/galal-hussein/consul-config).
 
### Usage:
 
 Select Consul from catalog.

 Enter the certificates and keys for consul nodes, ca certificates, and the encryption key.

 Click deploy.
 
 The consul nodes will be bound to the Rancher managed network IPs.
