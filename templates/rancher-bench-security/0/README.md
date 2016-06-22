# rancher-security-bench

### Info:

This template provides information about security issues in your rancher environment. It follow the recomendations of of https://dockerbench.com/

It has a logic to run in every docker host of your rancher enironment and a web interface to see the results


### Usage:

The web interface runs on the port 80 of "web-server" service.

You can access to it by adding a rancher load balancer or using traefik proxy.

If you want to use traefik proxy just configure the domain parameter. The web will be accesible at http://rancher-security-bench.<YOUR DOMAIN>

If you do not want to use traefik proxy just ignore the domain parameter

You can customize the time interval in wich the automatic tests will be run. Just tune the "Refresh Interval" option.
