# Apache Zookeeper (Experimental)

### Info:

 This template creates, scale in and scale out a multinodes zk (zookeeper) cluster on top of k8s. The configuration is generated with confd watching k8s metadata. 
 Cluster size are variable after deployment, and get reconfigured if you scale.

 The services generates ZKID's (saving them as pod labels) and start the zookeeper cluster.
 
 
### Usage:

 Select Apache Zookeeper from catalog. 

 Change the following zookeeper default parameters, if you need:

- zk_name="zookeeper"			# Name of the k8s rc and service.
- zk_namespace="default"		# Name of the k8s namespace
- zk_scale="3"					# Number of zk replicas
- zk_mem="512"					# Mem to configure zk.
- zk_data_dir="/opt/zk/data"	# Zk dataDir param value
- zk_init_limit="10"			# zk initLimit param value
- zk_max_client_cxns="500"		# zk maxClientCnxns param value
- zk_sync_limit="5"				# zk syncLimit param value
- zk_tick_time="2000"			# zk tickTime param value
 
 Click deploy.
 
 Zookeeper can now be accessed over the Rancher network. 

Testing Feature: When you scale the cluster, zero downtime is expected... 
