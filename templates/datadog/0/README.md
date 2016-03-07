# DataDog Agent Service

## Info
Based on the official [Datadog Agent Docker image](github.com/DataDog/docker-dd-agent) with a few changes to the init script to better support the Rancher environment.

## Notable Improvements
* Hostname reported to DataDog is the actual name of the host (per Rancher Metadata service)
* User can specify host labels which will be sent to DataDog as key:value tags for the host
* User can either deploy the DogStat Agent globally on every host or deploy a single instance of a standalone DogStatsD
* The later is useful if you just want a StatsD aggregator to which other services can send metrics

[Github repository for the image](https://github.com/janeczku/dd-agent-rancher)
[Docker Hub trusted image builds](https://hub.docker.com/r/janeczku/dd-agent-rancher)
