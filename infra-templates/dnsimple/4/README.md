## DNSimple DNS

Rancher External DNS service powered by DNSimple DNS

#### Changelog

##### v0.7.11

This criticial update ensures that the provider continuous to work after the shutdown of DNSimple's v1 API on May 31st, 2018. See [announcement](https://blog.dnsimple.com/2018/03/api-v1-shutdown-notice/).

#### Usage

##### Upgrade Notes

- Starting with v0.7.11 this provider must be configured with an OAuth **account access token**. You can generate that token in your DNSimple control panel.

- When upgrading from a version lower than v0.6.0 the TTL configuration value should not be changed. You may change it once the upgrade has been completed.

##### Limitation when running the service on multiple Rancher servers

When running multiple instances of the External DNS service configured to use the **same** domain name, then only one of them can run in the "Default" environment of a Rancher server instance.

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
Override the DNS name template for specific services (see below)

##### Custom DNS name template

By default DNS entries are named `<service>.<stack>.<environment>.<domain>`.    
You can specify a custom name template used to construct the subdomain part (left of the domain/zone name) of the DNS records. The following placeholders are supported:

* `%{{service_name}}`
* `%{{stack_name}}`
* `%{{environment_name}}`

**Example:**

`%{{stack_name}}-%{{service_name}}.statictext`

Make sure to only use characters in static text and separators that your provider allows in DNS names.
