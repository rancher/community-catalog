# Apache Zookeeper (Experimental)


### Info:

 This template creates, scale in and scale out a multinodes zk (zookeeper) cluster on top of Rancher. The configuration is generated with confd from Rancher metadata. 
 Cluster size are variable after deployment, and get reconfigured if refresh interval > 0.
 
 
### Usage:

 Select Apache Zookeeper from catalog. 
 
 Enter the number of nodes, mem and refresh interval for the zk cluster. (set refresh data to 0 to disable dinamic config)

 Note: When you scale the cluster, zero downtime is not guaranteed..yet..
 
 Click deploy.
 
 Zookeeper can now be accessed over the Rancher network. 

