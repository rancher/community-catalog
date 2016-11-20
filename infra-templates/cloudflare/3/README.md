## CloudFlare DNS

Rancher External DNS service powered by CloudFlare DNS

#### Changelog

##### v0.6.0

* Reduces the overall rate of API requests to the DNS provider
* Adds support for custom DNS naming convention
* Stack, service and environment names used in service DNS names are now sanitized to conform with RFC 1123. Characters other than `a-z`, `A-Z`, `0-9` or `dash` are replaced by dashes.
* For internal use the service creates TXT records to track the FQDNs it manages. These TXT records are named `external-dns-<environemntUUID>.<domain>` and should not be deleted.

#### Usage

##### Upgrade Notes
While upgrading from a version lower than v0.6.0 the TTL configuration value should not be changed. You may change it once the upgrade has been completed.

##### Limitation when running the service on multiple Rancher servers

When running multiple instances of the External DNS service configured to use the **same** domain name, then only one of them can run in the "Default" environment of a Rancher server instance.

##### Custom DNS name template

By default DNS entries are named `<service>.<stack>.<environment>.<domain>`.    
You can specify a custom name template used to construct the subdomain part (left of the domain name) of the DNS records. The following placeholders are supported:

* `%{{service_name}}`
* `%{{stack_name}}`
* `%{{environment_name}}`

**Example:**

`%{{stack_name}}-%{{service_name}}.statictext`

Make sure to only use characters in static text and separators that are allowed by your provider in DNS names.
