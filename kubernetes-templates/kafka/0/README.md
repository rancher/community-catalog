# Apache Kafka (Experimental)

### Info:

 This template creates, scale in and scale out a multinodes kafka broker cluster on top of k8s. The configuration is generated with confd from k8s. 
 Cluster size are variable after deployment, and get reconfigured.
 
 
### Usage:

 Select Apache Kafka from catalog. 
 
 Enter the number of nodes, mem and refresh interval for the kafka cluster.
 
 Change the following kafka default parameters, if you need:

- kafka_name="kafka"					# kafka k8s service and rc name.
- kafka_namespace="kafka"				# kafka k8s namespace
- kafka_scale=3							# kafka scale to deploy.
- kafka_mem=512							# kafka broker memory.
- kafka_log_dir="/opt/kafka/logs"		# Kafka log dir.
- kafka_log_retention="168"				# kafka log retention. 
- kafka_num_partitions="1"				# Kafka partitions number
- kafka_delete_topics="false"			# kafka delete topics
- kafka_pub_ip= < true | false >		# Advertise public ip to zookeeper.
- zk_link="kafka-zk/zk" 				# zookeeper namespace/service to connect to.
 
 Click deploy.
 
 Kafka can now be accessed over the Rancher network. 

 Note: When you scale the cluster, zero downtime is not guaranteed..yet..

