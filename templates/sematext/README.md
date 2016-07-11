[Sematext Docker Agent](https://github.com/sematext/sematext-agent-docker) collects Metrics, Events and Logs from the Docker API for [SPM Docker Monitoring](http://sematext.com/spm/integrations/docker-monitoring.html) & [Logsene](http://sematext.com/logsene) Log Management. 

This template deploys Sematext Docker Agent globally to monitor all containers on every RancherOS cluster node.

## Highlights
- Autodiscovery of containers
- Detailed host and [container metrics](https://sematext.com/blog/2016/06/28/top-docker-metrics-to-watch/)
- Tracking of Docker events
- Tagging of logs with Swarm and Kubernetes metadata
- Log format detection and parsing 

## Quickstart 

1. Get a free account [apps.sematext.com](https://apps.sematext.com/users-web/register.do)  
2. [Create an SPM App of type “Docker”](https://apps.sematext.com/spm-reports/registerApplication.do) to obtain the SPM Application Token
3. Create a [Logsene](http://www.sematext.com/logsene/) App to obtain the Logsene Token
4. Customize [Sematext Docker Agent settings](https://github.com/sematext/sematext-agent-docker#configuration-parameters) in the template below 

## Support
1. Please check the [SPM for Docker Wiki](https://sematext.atlassian.net/wiki/display/PUBSPM/SPM+for+Docker)
2. If you have questions about SPM for Docker, chat with us in the [SPM user interface](https://apps.sematext.com/users-web/login.do) or drop an e-mail to support@sematext.com
3. Open an issue [here](https://github.com/sematext/sematext-agent-docker/issues) 
4. Contribution guide [here](https://github.com/sematext/sematext-agent-docker/blob/master/contribute.md)

