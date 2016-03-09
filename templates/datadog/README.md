# DataDog Agent & DogStatsD

This service uses the [official](https://www.github.com/DataDog/docker-dd-agent) Datadog Agent image and a sidekick data volume containing a customized entrypoint script for improved integration with the Rancher environment.

* The `hostname` reported to DataDog is the actual name of the host
* You may specify `host labels` which are used as DataDog tags
* Service will be deployed globally by default so that every host is monitored by a `DataDog Agent`
* Alternatively you may deploy just a single `DogStatsD` instance which then acts as a metrics aggregator for other services
