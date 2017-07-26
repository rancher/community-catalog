##Harbor 0.5.0 deployment: single-host (revision 0)

This version deploys `Harbor` 0.5.0 on a single host of a Cattle cluster.

The host is identified, by default, by the `harbor-host=true` label (can be changed at deployment time to point to another key).

Note that:
- the `IP/Hostname/FQDN` parameter needs to be set to the exact same name you will use to access the registry (e.g. IP or FQDN of the host)
- the host needs to have port `80` and port `443` free for use (the Harbor proxy container will bind to those ports)
- this catalog entry only supports `http` (`https` access is not supported)
- because only `http` is supported, the Docker Host pulling/pushing from/to Harbor needs to have the `--insecure-registry` flag properly configured
- if you want to re-provision Harbor on the same Docker host and you want to use different inputs (e.g. a different password) you need to remove the `/data` directory on the host. If you fail to do so the new Harbor instance will use the same parameters entered in the previous deployment (saved in the `/data` directory)

![](singlehost.png)
