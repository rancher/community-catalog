# Traefik active load balancer (Experimental)

### Info:

 This template deploys traefik active load balancers on top of Rancher. The configuration is generated and updated with confd from Rancher metadata. 
 It would be deployed in hosts with label traefik_lb=true.

### Config:

- host_label = "traefik_lb=true" # Host label where to run traefik service.
- http_port = 8080  # Port exposed to get access to the published services.
- https_port = 8443  # Port exposed to get secured access to the published services.
- admin_port = 8000  # Port exposed to get admin access to the traefik service.
- https_enable = <false | true | only>
  - false: Enable http enpoints and disable https ones.
  - true: Enable http and https endpoints.
  - only: Enable https endpoints and redirect http to https.
- acme_enable = false               # Enable/Disable acme traefik support.
- acme_email = "test@traefik.io"    # acme user email
- acme_ondemand = true              # acme ondemand parameter.
- acme_onhostrule = true            # acme onHostRule parameter.
- ssl_key # Paste your ssl key. *Required if you enable https
- ssl_crt # Paste your ssl crt. *Required if you enable https
- refresh_interval = 10s  # Interval to refresh traefik rules.toml from rancher-metadata.

### Service configuration labels:

Traefik labels has to be added in your services, in order to get included in traefik dynamic config.

- traefik.enable = <true | false> 
  - true: the service will be published as *service_name.stack_name.traefik_domain*
  - stack: the service will be published as *stack_name.traefik_domain*. WARNING: You could have collisions inside services within your stack
  - false: the service will not be published
- traefik.priority = <priority>     	  	# Override for frontend priority. 5 by default
- traefik.protocol = < http | https	>		# Override the default http protocol
- traefik.sticky = < true | false	>		# Enable/disable sticky sessions to the backend
- traefik.alias = < alias >					# Alternate names to route rule. Multiple values separated by ",". traefik.domain is appended. WARNING: You could have collisions BE CAREFULL
- traefik.alias.fqdn = < alias fqdn >					# Alternate names to route rule. Multiple values separated by ",". traefik.domain must be defined but is not appended here.
- traefik.domain = < domain.name >			# Domain names to route rules. Multiple domains separated by ","
- traefik.domain.regexp = < domain.regexp > # Domain name regexp rule. Multiple domains separated by ","
- traefik.port = < port >           # Port to expose throught traefik  
- traefik.acme = < true | false >   # Enable/disable ACME traefik feature
- traefik.path = < path >                   # Path rule. Multiple values separated by ","
- traefik.path.strip = < path >             # Path strip rule. Multiple values separated by ","
- traefik.path.prefix = < path >            # Path prefix rule. Multiple values separated by ","
- traefik.path.prefix.strip = < path >      # Path prefix strip rule. Multiple values separated by ","

Details for configuring the traefik rules can be found at: https://docs.traefik.io/basics/#frontends

WARNING: Only services with healthy state are added to traefik, so health checks are mandatory.

### Usage:

 Select Traefik from catalog. 
 
 Set the params.

 Click deploy.

 Services will be accessed throught hosts ip's whith $host_label: 

 - http://${service_name}.${stack_name}.${traefik.domain}:${http_port}
 - https://${service_name}.${stack_name}.${traefik.domain}:${https_port}
 
 or 
 
 - http://${stack_name}.${traefik.domain}:${http_port}
 - https://${stack_name}.${traefik.domain}:${https_port}

 If you set traefik.alias you service could also be acceses through

 - http://${traefik.alias}.${traefik.domain}:${http_port}
 - https://${traefik.alias}.${traefik.domain}:${https_port}

Note: To access the services, you need to create A or CNAMES dns entries for every one. 

