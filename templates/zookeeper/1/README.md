# Apache Zookeeper (Experimental)

### Info:

 This template creates, scale in and scale out a multinodes zk (zookeeper) cluster on top of Rancher. The configuration is generated with confd from Rancher metadata. 
 Cluster size are variable after deployment, and get reconfigured if refresh interval > 0.
 
 
### Usage:

 Select Apache Zookeeper from catalog. 
 
 Enter the number of nodes, mem and refresh interval for the zk cluster. (set refresh data to 0 to disable dinamic config)

 Change the following zookeeper default parameters, if you need:

- ZK_DATA_DIR="/opt/zk/data"
- ZK_INIT_LIMIT="10"
- ZK_MAX_CLIENT_CXNS="500"
- ZK_SYNC_LIMIT="5"
- ZK_TICK_TIME="2000"
 
 Click deploy.
 
 Zookeeper can now be accessed over the Rancher network. 

 Note: When you scale the cluster, zero downtime is not guaranteed..yet..
