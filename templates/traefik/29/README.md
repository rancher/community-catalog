# Traefik active load balancer

### Info:

 This template deploys traefik active load balancers on top of Rancher. The configuration is generated and updated with confd from Rancher metadata.
 It would be deployed in hosts with label traefik_lb=true.

### Config:

- rancher_integration = "metadata" # Rancher integration method.
- rancher_healthcheck = false   # Enable/Disable traefik rancher services healthcheck filter. Only valid for api and metadata integration.
- usage_enable = false              # Enable/disable send Traefik [anonymous usage collection](https://docs.traefik.io/basics/#collected-data) 
- constraints = ""  # Traefik constraints for rancher provider. Only valid for api and metadata integration.
- host_label = "traefik_lb=true" # Host label where to run traefik service.
- http_port = 8080  # Port exposed to get access to the published services.
- https_port = 8443  # Port exposed to get secured access to the published services. 
- admin_port = 8000  # Port exposed to get admin access to the traefik service.
- admin_ssl = false  # Enable/Disable ssl on api, rest, ping and webui using  `ssl_key` and `ssl_crt` 
- https_enable = <false | true | only>
  - false: Enable http enpoints and disable https ones.
  - true: Enable http and https endpoints.
  - only: Enable https endpoints and redirect http to https.
- https_min_tls = "" # See the [traefik documentation](https://docs.traefik.io/configuration/entrypoints/#specify-minimum-tls-version) for allowed values.
- trusted_ips=""                      # Enable [proxyProtocol](https://docs.traefik.io/configuration/entrypoints/#proxyprotocol) and [forwardHeaders](https://docs.traefik.io/configuration/entrypoints/#forwarded-header) for these IPs (eg: "172.0.0.0/16,192.168.0.1")
- acme_enable = false               # Enable/Disable acme traefik support. [acme](https://docs.traefik.io/configuration/acme/)
- acme_email = "test@traefik.io"    # acme user email
- acme_challenge = http             # acme challenge parameter. WIP to support dns.
- acme_onhostrule = true            # acme onHostRule parameter.
- acme_caserver = "https://acme-v01.api.letsencrypt.org/directory"          # acme caServer parameter.
- acme_vol_name = "traefik_acme_vol"    # Volume name to user by acme sidekick
- acme_vol_driver = "local"   # Volume driver to user by acme sidekick
- acme_keytype = "RSA4096"   # acme keytype to use [acme keytype](https://docs.traefik.io/configuration/acme/)
- ssl_key # Paste your ssl key. *Required if you enable https
- ssl_crt # Paste your ssl crt. *Required if you enable https
- insecure_skip = false # Enable InsecureSkipVerify param.
- compress_enable = true    # Enable traefik compression
- timeout_read="0"          # respondingTimeouts [readTimeout](https://docs.traefik.io/configuration/commons/#responding-timeouts)
- timeout_write="0"         # respondingTimeouts [writeTimeout](https://docs.traefik.io/configuration/commons/#responding-timeouts)
- timeout_idle="180"        # respondingTimeouts [idleTimeout](https://docs.traefik.io/configuration/commons/#responding-timeouts)
- timeout_dial="30"         # forwardingTimeouts [dialTimeout](https://docs.traefik.io/configuration/commons/#forwarding-timeouts)
- timeout_header="0"        # forwardingTimeouts [responseHeaderTimeout](https://docs.traefik.io/configuration/commons/#forwarding-timeouts)
- refresh_interval = 10s  # Interval to refresh traefik rules.toml from rancher-metadata.
- admin_readonly = false # Set REST API to read-only mode.
- admin_statistics = 10 # Enable more detailed statistics, extend recent errors number.
- admin_auth_method = "basic" # Selec auth method, basic or digest.
- admin_users = "" # Paste basic or digest users created with htdigest, one user per line.
- metrics_enable="false"        # Enable/disable traefik [metrics](https://docs.traefik.io/configuration/metrics/)  
- metrics_exporter=""           # Metrics exporter prometheus | datadog | statsd | influxdb 
- metrics_push="10"             # Metrics exporter push interval (s). datadog | statsd | influxdb
- metrics_address=""            # Metrics exporter address. datadog | statsd | influxdb 
- metrics_prometheus_buckets="[0.1,0.3,1.2,5.0]"  # Metrics buckets for prometheus
    
### Service configuration labels:

Traefik labels has to be added to your services, in order to get included in traefik config.

#### Metadata or api

Please use traefik defined labels if you choose metadata or api rancher integration. 

[Traefik rancher backend labels][traefik rancher backend]

Metadata is the prefered and recommended rancher integration.

#### External

Use this labels if you choose extenal rancher integration.

- traefik.enable = < true | stack | false > #Controls if you want to publish or not the service
  - true: the service will be published as *service_name.stack_name.traefik_domain*
  - stack: the service will be published as *stack_name.domain*. WARNING: You can have collisions inside services within your stack
  - false: the service will not be published
- traefik.priority = <priority>             # Override for frontend priority. Default `5`
- traefik.protocol = < http | https >       # Override the default protocol `http`
- traefik.sticky = < true | false   >       # Enable/disable sticky sessions to the backend. Default `false`
- traefik.backend.loadbalancer.method = < drr | wrr > # Override default lb algorithm `drr`
- traefik.backend.circuitbreaker.expression = < expression > # Override default backend circuitbreaker expression `NetworkErrorRatio() > 0.5`
- traefik.frontend.passHostHeader = < true | false > # Forward client Host header to the backend. Default `true`
- traefik.weight = < weight >               # Override default backend weight `5`
- traefik.alias = < alias >                 # Alternate names to route rule. Multiple values separated by ",". traefik.domain is appended. WARNING: You could have collisions BE CAREFULL
- traefik.alias.fqdn = < alias fqdn >                   # Alternate names to route rule. Multiple values separated by ",". traefik.domain must be defined but is not appended here.
- traefik.domain = < domain.name >          # Domain names to route rules. Multiple domains separated by ","
- traefik.domain.regexp = < domain.regexp > # Domain name regexp rule. Multiple domains separated by ","
- traefik.port = <port>                     # port to expose throught traefik. Default `80`
- traefik.acme = < true | false >           # Enable/disable ACME traefik feature. Default `false`
- traefik.path = < path >                   # Path rule. Multiple values separated by ","
- traefik.path.strip = < path >             # Path strip rule. Multiple values separated by ","
- traefik.path.prefix = < path >            # Path prefix rule. Multiple values separated by ","
- traefik.path.prefix.strip = < path >      # Path prefix strip rule. Multiple values separated by ","
- traefik.ratelimit.enable = < true | false >   # Enable/disabe rate-limiting based on client ip. Default `false`
- traefik.ratelimit.period = < n >          # Replace n with desired amount of seconds in which traefik is checking the limits "average" and "burst". Default `10`
- traefik.ratelimit.average = < n >         # Change to desired average allowed requests by client ip. Default `100`
- traefik.ratelimit.burst = < n >           # State what limit the client ip is allowed to burst up to respectively. Default `200`

WARNING: Only services with healthy state are added to traefik, so health checks are mandatory.

More info [rancher-traefik][rancher-traefik]

### Usage:

 Select Traefik from catalog.

 Set the params.

 Click deploy.

 Access your traefik admin service at $admin_port to see your published services.

Note: To access the services, you need to create A or CNAMES dns entries for every one.

### Usage examples

#### Setup Traefik for a custom domain

You must set these labels for the service your want to expose:
- traefik.enable = true
- traefik.port = 8080
- traefik.acme = true
- traefik.frontend.rule = Host:MyCustoDomain.com (`api` or `metadata` rancher integration)
- traefik.domain = MyCustoDomain.com (`external` rancher integration)

### F.A.Q

#### Q: Traefik doesn't apply labels

Depending on traefik rancher integration, available labels are differents.
- [api and metadata][traefik rancher backend]
- [external][rancher-traefik]

#### Q: Traefik doesn't expose my service

Depending on Traefik configuration we can diffenciate two cases:
- If you configured Traefik with label *rancher_healthcheck=true* -> ensure your service has a healthcheck
- If you configured Traefik without healthcheck, then check the Traefik log. Some times Traefik fails when try to load an invalid config and, before that, doesn't load new services -> restart Traefik should fix that

[traefik rancher backend]: https://docs.traefik.io/configuration/backends/rancher/#labels-overriding-default-behaviour
[rancher-traefik]: https://github.com/rawmind0/rancher-traefik
