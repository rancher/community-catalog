# Traefik active load balancer (Experimental)

### Info:

 This template deploys traefik active load balancers on top of Rancher. The configuration is generated and updated with confd from Rancher metadata. 
 It would be deployed in hosts with label traefik_lb=true.

### Config:

- http_port = 8080  # Port exposed to get access to the published services.
- admin_port = 8000  # Port exposed to get admin access to the traefik service.
- refresh_interval = 60s  # Interval to refresh traefik rules.toml from rancher-metadata.

### Service configuration labels:

Traefik labels has to be added in your services, in order to get included in traefik dynamic config.

- traefik.enable = <true | false> 
- traefik.domain = < domainname to route rule > 
- traefik.port = < port to expose throught traefik > 
 
 
### Usage:

 Select Traefik from catalog. 
 
 Enter the http_port, admin_port and refresh_interval.

 Click deploy.

 Services will be accessed throught hosts whith traefik_lb=true at http://${service_name}.${service_name}.${traefik.domain}:${http_port}

