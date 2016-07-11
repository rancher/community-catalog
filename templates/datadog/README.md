# Datadog Agent & DogStatsD

This template deploys a Datadog Agent stack consisting of the official [docker-dd-agent image](https://www.github.com/Datadog/docker-dd-agent) and a sidekick config volume with a custom entrypoint script for improved integration with the Rancher Cattle environment:

* Reports the actual name of the host instead of the container's hostname
* Let's you specify `host` and `service` labels to be mapped to Datadog tags
* Starts as global service by default so that system and Docker metrics from every host are captured
* Allows deployment as a standalone `DogStatsD` service that aggregates StatsD metrics sent from applications
