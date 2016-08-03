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
2. Find 1 surviving container. Survivors will be in running state (green circle on the UI). These containers are DR candidates. From the dropdown menu, select `Execute Shell`. Type `disaster` and hit enter. The script will automatically restart the container in disaster recovery mode. Once the recovery process completes, etcd will begin servicing requests and downstream containers should return to a functional state.
3. Add more hosts so your etcd service may scale up to the desired size. In the unlikely event you experienced a majority of hosts failing simultaneously and had a surplus of hosts, you will have unhealthy Etcd containers scheduled to other hosts. Wait for 5 minutes for these containers to become healthy. If after 5 minutes they are still initializing, restart them.

### Limitations

For 3+ node deployments in environments using etcd heavily, it is theoretically possible (but improbable) for etcd to temporarily lose quorum during upgrade. The next template will make use of new features available in etcd v3.0.0 that expose the raft index to clients, thereby making it possible to deduce if an upgraded node has caught up with the rest of the cluster. This will deprecate the use of non-deterministic waiting periods.

### Changelog

* Upgrade to etcd v2.3.7
* Re-work DR script to automate restart of container and perform backup only after etcd termination
* Proxy health check and add a waiting period before reporting healthy, preventing upgrades from losing quorum in most cases
