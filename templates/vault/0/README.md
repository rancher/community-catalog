# Vault #

### Info:

This template deploys a Hashicorp Vault server along with a Rancher LoadBalancer.  Once it is deployed, you will have a working Vault server ready to be scaled up to meet your environment's needs.

The template is designed to be flexible in how you configure it; you can either statically bind Vault to an existing Consul stack, or ignore Consul all together and paste in your own Vault configuration.

This catalog item uses these two main containers:
* [Vault](https://www.vaultproject.io) - The official Hashicorp Vault image
* [Rancher LoadBalancer](https://hub.docker.com/r/rancher/lb-service-haproxy/) - Rancher's own official HAProxy load balancer

## Deployment:
1. Select the catalog item and choose a version from the drop-down box
2. Adjust any values on the page to meet your needs.
3. Make any adjustments to the default config provided, such as:
   * A different backend than the Consul server specified.
   * Different ports to listen on (NOTE: Vault ALWAYS listens on port 8200, but you can adjust the LoadBalancer ports to any that are acceptable to your environment; the LoadBalancer handles routing between the port you specify and port 8200 (and 8201) in Vault itself.
4. Specify the Volume Driver for pesistent mounting of Vault's FILE backing store, and CONFIGURATION
5. Finally, once the stack is up, you can use your normal Vault process to init, unseal, and more.
6. Enjoy!

## Backend Configuration
This field is for specifying your backend configuration options.  You enter them in a JSON key:value pair format just as you would in a JSON Vault configuration file; with each separate element being comma-delimited.  For example:
```
"address":"http://locahost:2379","etcd_api":"v3"
```
would be a valid configuration for Etcd and
```
"access_key":"abcd1234","secret_key":"defg5678","bucket":"my-bucket"
```
would be valid for Amazon S3 buckets.:w

