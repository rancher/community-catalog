# Datadog agent

This template deploys a [Datadog](https://www.datadoghq.com/) agent stack consisting of the official [docker-dd-agent](https://www.github.com/Datadog/docker-dd-agent) image and a configuration sidekick that provides closer integration with Rancher:

* Hosts in Datadog are named correctly
* Host labels can be exported as Datadog host tags
* Service labels can be exported as Datadog metric tags

## Service Discovery

Please refer to the Datadog documentation [here](http://docs.datadoghq.com/guides/servicediscovery/) to learn how to provide configuration templates for Service Discovery in etcd or Consul.

## Changelog

**1.1.1-11.0.5140**

* Datadog image updated to v5.1.40 which includes the following Rancher specific changes:
    * Service Discovery: Add ability to get docker IP address from Rancher labels for Rancher
    * Docker: Fix cgroup parsing on RancherOS
* Switched to use the Alpine based agent image
* Added template configuration of Proxy settings
* Added template configuration to disable DogStatsD
* Added template configuration to overwrite DD intake URL
