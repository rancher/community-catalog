# Traefik active load balancer (Experimental)

### Info:

 This template deploys Traefik active load balancers on top of Rancher. The configuration is generated and updated with confd from Rancher metadata. 
 It would be deployed in hosts with label traefik_lb=true.

### Config:

- host_label = "traefik_lb=true" # Host label where to run traefik service.
- http_port = 8080  # Port exposed to get access to the published services.
- https_port = 8443  # Port exposed to get secured access to the published services.
- admin_port = 8000  # Port exposed to get admin access to the traefik service.
- https_enable = <false | true | only>
  - false: Enable http enpoints and disable https ones.
  - true: Enable http and https endpoints.
  - only: Disable http endpoints and enable https ones.
- ssl_key # Paste your ssl key. Defaul value a test one
- ssl_crt # Paste your ssl crt. Defaul value a test one
- refresh_interval = 60s  # Interval to refresh traefik rules.toml from rancher-metadata.

### Service configuration labels:

Traefik labels has to be added in your services, in order to get included in Traefik dynamic config.

- traefik.enable = <true | false> 
  - true: the service will be published as *service_name.stack_name.traefik_domain*
  - stack: the service will be published as *stack_name.domain*. WARNING: You can have collisions inside services within yout stack
  - false: the service will not be published
- traefik.domain = < domain names to route rule. Multiple values separated by "," > 
- traefik.port = < port to expose throught traefik >  
 
### Usage:

 Select Traefik from catalog. 
 
 Set the params.

 Click deploy.

 Services will be accessed through hosts with traefik_lb=true at: 
 - http://${service_name}.${stack_name}.${traefik.domain}:${http_port}
 - https://${service_name}.${stack_name}.${traefik.domain}:${https_port}
 or 
 - http://${stack_name}.${traefik.domain}:${http_port}
 - https://${stack_name}.${traefik.domain}:${https_port}
