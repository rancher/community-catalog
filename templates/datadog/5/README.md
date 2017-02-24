# Datadog agent

This template deploys a [Datadog](https://www.datadoghq.com/) agent stack consisting of the official [docker-dd-agent](https://www.github.com/Datadog/docker-dd-agent) image and a configuration sidekick that provides closer integration with Rancher:

* Hosts in Datadog are named correctly
* Host labels can be exported as Datadog host tags
* Service labels can be exported as Datadog metric tags

## Service Discovery
**Note**: Service discovery templates that contain the `%%host%%` placeholder are currently not working in Rancher 1.2 and up due to the switch to CNI networking.

Please refer to the Datadog documentation [here](http://docs.datadoghq.com/guides/servicediscovery/) to learn how to provide configuration templates for Service Discovery in etcd or Consul.

## Changelog

**1.1.0-11.0.5110**

New versioning scheme: `<TemplateVersion>-<DatadogImageVersion>`

* DEPRECATED: DogStatsd standalone mode
* NEW: Configure global host tags
* NEW: Configure custom log verbosity
* NEW: Enable collection of AWS EC2 custom tags
* NEW: Support for Amazon Linux AMIs
* NEW: Enable Datadog trace agent
