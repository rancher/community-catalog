# Hadoop + Yarn (Experimental)


### Info:

 This template will install Apache Hadoop 2.7.1 and Yarn on Rancher network. It is recommended that Hadoop be installed on instances with 8+GB of ram. This image also makes use of 'named' volumes and requires Docker 1.9.x (Ideally, 1.9.1), One Hadoop cluster can be deployed per environment. Additional nodes can be added to the cluster, removing nodes is not currently setup.
 
### Using

Select Hadoop from the Rancher Catalog. Common HDFS options and Yarn/MapReduce memory options are available to set. 

Once the values are set, and the cluster is deployed:

On the hosts running the following services you can access

* HDFS manager on: `namenode-primary:50070`.
* Yarn Resource manager is accessible via `yarn-resourcemanager:8088` 

Your default HDFS filesystem URL is hdfs://<namenode>:8020 (Only available on Rancher Network)





