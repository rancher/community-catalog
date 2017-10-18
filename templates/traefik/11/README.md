# Traefik active load balancer

### Info:

 This template deploys traefik active load balancers on top of Rancher. The configuration is generated and updated with confd from Rancher metadata.
 It would be deployed in hosts with label traefik_lb=true.

### Config:

- rancher_integration = "metadata" # Rancher integration method.
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
- acme_caserver = "https://acme-v01.api.letsencrypt.org/directory"          # acme caServer parameter.
- acme_vol_name = "traefik_acme_vol"    # Volume name to user by acme sidekick
- acme_vol_driver = "local"   # Volume driver to user by acme sidekick
- ssl_key # Paste your ssl key. *Required if you enable https
- ssl_crt # Paste your ssl crt. *Required if you enable https
- insecure_skip = false # Enable InsecureSkipVerify param.
- compress_enable = true    # Enable traefik compression
- refresh_interval = 10s  # Interval to refresh traefik rules.toml from rancher-metadata.
- admin_readonly = false # Set REST API to read-only mode.
- admin_statistics = 10 # Enable more detailed statistics, extend recent errors number.
- admin_auth_method = "basic" # Selec auth method, basic or digest.
- admin_users = "" # Paste basic or digest users created with htdigest, one user per line.
- prometheus_enable = false # Enable prometheus statistics
- prometheus_buckets = "[0.1,0.3,1.2,5.0]" # Prometheus buckets
- cattle_url = ""           # Cattle url if you choose api integration
- cattle_access_key = ""    # Cattle access key if you choose api integration
- cattle_secret_key = ""    # Cattle secret key if you choose api integration    
### Service configuration labels:

Traefik labels has to be added to your services, in order to get included in traefik config.

## Metadata or api

Please use traefik defined labels if you choose metadata or api rancher integration. 

[Traefik rancher backend labels][traefik rancher backend]

Metadata is the prefered and recommended rancher integration.

Api integration needs you create an environment API key in your rancher environment. Also, it needs you provide CATTLE_URL, CATTLE_ACCESS_KEY and CATTLE_SECRET_KEY.

## External

Use this labels if you choose extenal rancher integration.

- traefik.enable = <true | false>
  - true: the service will be published as *service_name.stack_name.traefik_domain*
  - stack: the service will be published as *stack_name.traefik_domain*. WARNING: You could have collisions inside services within your stack
  - false: the service will not be published
- traefik.alias = < alias >         # Alternate names to route rule. Multiple values separated by ",". WARNING: You could have collisions BE CAREFULL
- traefik.domain = < domain >       # Domain names to route rule. Multiple values separated by ","
- traefik.path = < path >           # Path to route rule. Multiple paths separated by ","
- traefik.port = < port >           # Port to expose throught traefik
- traefik.acme = < true | false >   # Enable/disable ACME traefik feature

### Usage:

 Select Traefik from catalog.

 Set the params.

 Click deploy.

 Access your traefik admin service at $admin_port to see your published services.

Note: To access the services, you need to create A or CNAMES dns entries for every one.

[traefik rancher backend]: https://docs.traefik.io/configuration/backends/rancher/#labels-overriding-default-behaviour
