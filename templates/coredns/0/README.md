## CoreDNS

CoreDNS (written in Go) chains [plugins](https://coredns.io/plugins). Each plugin performs a DNS
function.

CoreDNS is a [Cloud Native Computing Foundation](https://cncf.io) incubating level project.

CoreDNS is a fast and flexible DNS server. The keyword here is *flexible*: with CoreDNS you
are able to do what you want with your DNS data by utilizing plugins. If some functionality is not
provided out of the box you can add it by [writing a plugin](https://coredns.io/explugins).


And more. Each of the plugins is documented. See [coredns.io/plugins](https://coredns.io/plugins)
for all in-tree plugins, and [coredns.io/explugins](https://coredns.io/explugins) for all
out-of-tree plugins.

## Dockerfile
The Dockerfile source is under below:
[https://github.com/Jason-ZW/Dockerfile/tree/master/coredns](https://github.com/Jason-ZW/Dockerfile/tree/master/coredns)

## Parameters

- Publish port: Port to publish coredns service. (eg. 53)
- DNS zone names: you can put multiple zone names.（eg. rancher.io,rancher.io,172.in-addr.arpa）
- Etcd root path: etcd root path which is used to save records. (eg. /skydns)
- Etcd endpoints: etcd service endpoints，this catalog don't include etcd service,please use external etcd service. (eg. http://localhost:2379, endpoints2, ...)
- UpStream for dns: upstream configuration for dns server. (eg. /etc/resolv.conf)
- Forward addresses: the address which to be forwarded DNS query. (eg. 8.8.8.8:53,8.8.4.4:53)
- Prometheus plugin support: whether to enable prometheus plugin.
- Errors plugin support: whether to enable errors plugin.
- Log plugin support: whether to enable log plugin.
- Proxy plugin support: whether to enable proxy plugin.
- Cache plugin support: whether to enable cache plugin.
- Loadbalance plugin support: whether to enable loadbalance plugin.

More detail for CoreDNS plugin
[https://coredns.io/plugins](https://coredns.io/plugins)

## Guide

Serve for DNS `A/AAAA` Records:

> Put DNS A record to etcd server.

```
curl -XPUT http://{ETCD_ENDPOINT}:2379/v2/keys/skydns/io/rancher/busybox -d value='{"host":"172.16.80.175","port":8080}'
```

> Set `nameserver` to `/etc/resolv.conf`.
```
nameserver {DNS_SERVER_ADDRESS}
search rancher.io
```

> Query DNS use dns tools(eg. `dig` or `nslookup`)
```
nslookup busybox.rancher.io

#output:
Server:		xxx.xxx.xxx.xxx
Address:	xxx.xxx.xxx.xxx#53

Name:	busybox.rancher.io
Address: 172.16.80.175
```

Serve for DNS `PTR` Records:
> Modify the DNS zone names section on Catalog template.

```
# DNS zone names section on Catalog template.
rancher.io,172.in-addr.arpa
```

> Put DNS PTR record to etcd server.
```
curl -XPUT http://{ETCD_ENDPOINT}:2379/v2/keys/skydns/arpa/in-addr/172/16/80/175 -d value='{"host":"busybox.rancher.io"}'
```

> Set `nameserver` to `/etc/resolv.conf`.
```
nameserver {DNS_SERVER_ADDRESS}
search rancher.io
```

> Query DNS use dns tools(eg. `dig` or `nslookup`)
```
dig @localhost -x 172.16.80.175 +short

#output:
busybox.rancher.io.
```

## Community

We're most active on Slack (and Github):

- Slack: #coredns on <https://slack.cncf.io>
- Github: <https://github.com/coredns/coredns>

More resources can be found:

- Website: <https://coredns.io>
- Blog: <https://blog.coredns.io>
- Twitter: [@corednsio](https://twitter.com/corednsio)
- Mailing list/group: <coredns-discuss@googlegroups.com>

**Notice: For kubernetes, please use helm coredns's chart.**