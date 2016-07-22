# Etcd 

A distributed key/value store that provides a reliable way to store data across a cluster of machines

### General

The template deploys an N-node cluster. Only 1 node is allowed per host. If less than N hosts are available, the largest cluster possible will be built with the resources available. Adding more hosts at a later date will result in the cluster scaling up to the maximum desired size.

### Upgrades

Starting with `2.3.6-rancher4`, upgrades are fully supported and require no user intervention beyond navigating the UI and selecting the desired version.

### Resiliency

Etcd can survive `floor(N/2)` recoverable or unrecoverable failures while maintaining 100% uptime. For recoverable host failures such as a power cycle, the service self-heals. For unrecoverable host failures, the service self-heals when sufficient resources are allocated to the environment. Therefore, it is not a bad idea to allocate an extra host beyond the specified cluster size. For instance, a 3-node deployment in a 4-host environment may survive 2 host failures, given enough time in-between to self-heal the cluster. The amount of time which must pass between host failures is indeterminate and depends on how much data must be replicated to the new node.

Etcd can survive `N` recoverable failures, but system downtime will be experienced once a majority of nodes (quorum) is lost.

Etcd can survive `N-1` unrecoverable failures, but will enter a disaster state where some user intervention is required to recover. Recovering from this situation is mostly-automated, but will not be fully automated. This is a very, very bad situation to be in and should never occur if appropriate steps are taken such as spreading hosts across availability zones.

### Disaster Recovery (DR)

If a majority of nodes are unrecoverably lost, you must re-build the cluster from one of the surviving nodes. The process involves selecting a survivor, transforming it into a standalone node, and adding new hosts so the service may scale back up to the desired size.

In more detail, follow these steps:

1. Determine if your lost hosts are truly unrecoverable. If on bare metal, this involves fixing or replacing hardware and rebooting. If in the cloud, check if the host was stopped and attempt to start it. If a host comes back online, wait at least 5 minutes to allow Network Agent to repair itself. You can figure out if the network is repaired by following [these steps](http://docs.rancher.com/rancher/latest/en/faqs/troubleshooting/#containers-on-hosts-unable-to-ping-each-other-how-to-check-that-the-hosts-can-ping-each-other) for the recovered host. If recovery fails, remove the dead hosts from the environment.
2. Find 1 surviving container. Survivors will be in running state (green circle on the UI). These containers are DR candidates. From the dropdown menu, select `Execute Shell`. Type `disaster` and hit enter. The script will backup the data directory to a special location within the container. Click `Close` to exit the shell.
3. From the dropdown menu of the same container, click `Restart`. This will trigger the disaster recovery automation which will sanitize the data directory, update cluster membership to reflect a new standalone deployment, and start the node. At this point, Etcd will begin servicing requests and downstream containers should return to a functional state.
4. In the unlikely event you experienced a majority of hosts failing simultaneously and had a surplus of hosts, you will have unhealthy Etcd containers scheduled to other hosts. Wait patiently and they will automatically join the cluster. If you did not have a surplus of hosts, add new ones and etcd will scale up to the desired size.

It is highly unlikely that you will ever need to perform these steps. If you've truly experienced a disaster scenario (and you didn't cause it), your infrastructure provider should be assessed for instability.

### Limitations

For upgrades, service downtime is inevitable for standalone deployments. In a 3-node deployment, service downtime may be experienced as quorum is lost for a brief period of time. This is a limitation of the template and will be addressed in future versions. 5+ node upgrades should see no downtime.

### Changelog

* Begin servicing requests as soon as the first container enters running state
* Solve the metadata race condition
* Make disaster recovery possible
