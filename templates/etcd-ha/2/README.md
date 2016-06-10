# Etcd 

A distributed, highly-available key/value store written in Go.

### Info

 This creates an N-node etcd cluster on top of Rancher. The bootstrap process is performed using a standalone etcd discovery node. Upon the cluster entering a running state, this discovery service will shutdown. The state of the etcd cluster is a key/value pair stored on etcd itself, in a hidden key at location `/_state`.

Etcd node restarts and upgrades are fully supported. Please only restart/upgrade `floor(N/2)` nodes at one time in order to maintain service stability. Restarting or upgrading all nodes at once will cause service downtime, but the volume containerization should prevent data loss. While this template can survive `floor(N/2)` node/data volume failures while maintaining service uptime, manual intervention may be required in the face of a corrupted data volume.

Scaling up an existing etcd cluster is fully automated using the [Etcd Members API](https://coreos.com/etcd/docs/2.3.0/members_api.html).

Scaling down is unsupported..


### Usage

Select etcd the catalog page.

Fill in the number of nodes desired. This should be an **ODD** number. Recommended configurations are 3, 5, or 7 node deployments. More nodes increases read availability while decreasing read latency. Less nodes decreases write latency, but sacrifices read latency and availability.

Click deploy.

Once the stack is deployed and assuming your application is deployed within it, you can access the etcd cluster in your application like so:

```
etcdctl --endpoints http://etcd:2379 member list
```

On the etcd cluster itself, ETCDCTL_ENDPOINT environment variable is set so you may inspect like so:

```
etcdctl member list
```

It is always possible that DNS will return an IP address for an etcd node that is dying. Your application should ensure connection retry logic exists when it uses etcd, or alternatively provide 2+ endpoints using IP addresses to ensure high availability.
 
### Changelog

* Fixed upgrade strategy to automatically shutdown discovery containers
* Refactor entrypoint script to use `giddyup` and `etcdctl`