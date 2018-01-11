# Rancher Pipeline

Easier to use, Easier to integrate CI/CD with Rancher.

## Description

This template deploys Rancher Pipeline, the continuous integration service powered by Jenkins.

It will be set up as an infrastructure stack in the Rancher environment.

## Prerequisite

Minimum system requirement of 2 core, 4 GB memory.

## Features

- Configure and manage your CI jobs in native Rancher UI.
- Simple to use, container based continuous integration system.
- multiple trigger types supported.
- Flexible CI flow control(stop, rerun, timeout, parallel/serial run, approve/deny, etc. ).

## Parameters

- `# of slaves`: The number of Jenkins slave to set up. Please set at least one slave. You can also do scaling of slaves after installation. 
- `# of executors`: The number of executors on each Jenkins slave. The maximum number of concurrent builds that Jenkins may perform on a agent. A good value to start with would be the number of CPU cores on the machine. Setting a higher value would cause each build to take longer, but could increase the overall throughput. For example, one build might be CPU-bound, while a second build running at the same time might be I/O-bound — so the second build could take advantage of the spare I/O capacity at that moment. Agents must have at least one executor. 


- `Host with Label to put pipeline components on`: This parameter specify the host labels to use. Pipeline components will be scheduled to dedicated hosts matching these host labels.

## Usage:

Select the template from the catalog.

Configure the parameters according to your workload and resource.

Click `Launch`.

After service is up, access Pipeline UI on top navigation bar of Rancher UI.

See [Pipeline documentation](https://github.com/rancher/pipeline) for detail information.
