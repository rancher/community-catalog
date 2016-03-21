# etcd (Experimental)


### Info:

 This creates an N-node etcd cluster on top of Rancher. The bootstrap process is done statically, and the adjustment of cluster scale needs to be managed manually. The cluster is available for immediate use.
 
 
### Usage:

Select etcd the catalog page.

Fill in the number of nodes desired. This should be an **ODD** number.

Click deploy.

Once the stack is deployed, you can access the cluster in your application via its IP or DNS addresses like so:


```
etcdctl -C http://10.42.16.231:2379,.... member list
```
 
 
 