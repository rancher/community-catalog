# DataDog Agent

This template deploys a [DataDog](https://www.datadoghq.com/) agent stack consisting of the official [docker-dd-agent](https://www.github.com/Datadog/docker-dd-agent) image and a configuration sidekick that provides closer integration with Rancher:

* Hosts in Datadog are named correctly
* Host labels can be exported as DataDog host tags
* Service labels can be exported as DataDog metric tags

## Service Discovery
Please refer to the Datadog documentation [here](http://docs.datadoghq.com/guides/servicediscovery/) to learn how to provide configuration templates for Service Discovery in etcd or Consul.

## Changelog

**11.3.585**

* Support for specifying connection options for Consul backends (ACL token, scheme, SSL certificate verification)