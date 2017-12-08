AWS ELB Classic External LB Service
==========

#### About ELB Classic Load Balancers
The [Classic Load Balancer](https://aws.amazon.com/elasticloadbalancing/classicloadbalancer/) option in AWS routes traffic based on application or network level information and is ideal for simple load balancing of traffic across multiple EC2 instances.

#### About this service
Load balance Rancher services using Elastic Load Balancing.
This service keeps existing ELB Classic load balancers updated with the EC2 instances on which Rancher services that have one or more exposed ports and the label `io.rancher.service.external_lb.endpoint` are running on.

#### Usage

1. Deploy this stack
2. Using the AWS Console create a Classic ELB load balancer with one or more listeners and configure it according to your applications requirements. Configure the listener(s) with an instance protocol and port matching that of the Rancher service that you want to forward traffic to.
3. Create or update your service to expose host ports that match the configuration of the ELB listener(s). Add the service label `io.rancher.service.external_lb.endpoint` using as value the name of the ELB load balancer you created.
