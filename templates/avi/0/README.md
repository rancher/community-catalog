Avi Vantage Platform Load Balancer Provider
========

## About Avi Vantage Platform
The [Avi Vantage Platform](https://avinetworks.com/software-load-balancer-for-any-cloud/) is built on software-defined architectural principles to create a centrally managed pool of distributed load balancers to deliver application services close to the applications.

## About this provider
This provider load balances Rancher services using Avi Vantage Platform Load Balancer. It uses REST API to update the Avi controller which enables the Avi Service Engines to load balance the Rancher Services.

## Usage

1. Deploy the stack for this provider from Rancher Community Catalog.
   While deploying, you need to give the username, password (optional,
   read below), Avi Controller IP address, Avi Controller Port, the
   Cloud name where Virtual Services and Pools are created.
2. Create Virtual Services using Avi Controller console. Make sure you
   create VS in given cloud in Avi. Leave the Virtual Service pool as
   empty. Configure any policies or rules for Virtual Service.
3. Create services in Rancher with public host port mapping and adding
   label `io.rancher.service.external_lb.endpoint` with value as Virtual
   Service name created in previous step. You can scale out/in the
   service or stop the service and the changes will get reflected on Avi
   Controller and Service Engine.

### Using Rancher Secrets for Avi Password

Optionally, you can use the Rancher Secrets to pass the Avi controller
password instead of using environment variable.
1. Run the Rancher Secrets service before deploying this provider stack.
2. Create a secret named "avi-creds".
3. While deploying the Avi provider stack, use the "avi-creds" secret
   for Avi Provider service.
