## Alibaba Cloud DNS

Rancher External DNS service powered by Alibaba Cloud DNS

#### Usage

##### Supported host labels

`io.rancher.host.external_dns_ip`
Override the IP address used in DNS records for containers running on the host. Defaults to the IP address the host is registered with in Rancher.

`io.rancher.host.external_dns`
Accepts 'true' (default) or 'false'
When this is set to 'false' no DNS records will ever be created for containers running on this host.

##### Supported service labels

`io.rancher.service.external_dns`
Accepts 'always', 'never' or 'auto' (default)
- `always`: Always create DNS records for this service
- `never`: Never create DNS records for this service
- `auto`: Create DNS records for this service if it exposes ports on the host

`io.rancher.service.external_dns_name_template`
Custom DNS name template that overrides global custom DNS name template (see below) of default DNS name template for a specific service

##### Custom DNS name template

By default DNS entries are named `<service>.<stack>.<environment>.<domain>`.
You can specify a custom name template used to construct the subdomain part (left of the domain/zone name) of the DNS records. The following placeholders are supported:

* `%{{service_name}}`
* `%{{stack_name}}`
* `%{{environment_name}}`

**Example:**

`%{{stack_name}}-%{{service_name}}.statictext`

Make sure to only use characters in static text and separators that your provider allows in DNS names.
