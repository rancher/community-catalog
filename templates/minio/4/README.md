# Minio.io

### Info:

This template creates, scale in and scale out a multinodes minio cluster on top of Rancher. The configuration is generated with confd from Rancher metadata.
Cluster size is static after deployement. It's mean that you should redeploy the stack if you should change the size of your cluster (minio.io limitation).


### Usage:

Select Minio Cloud Storage from catalog.

Enter the number of nodes for your minio cluster and set the key and secret to connect in minio.

Click deploy.

Minio can now be accessed over the Rancher network on port `9000` (http://IP_CONTAINER:9000). To access from external Rancher network, you need to set load balancer or expose the port 9000.
 
### Disks / nodes

You can set many disks per nodes (max of 4). If you use local disk (no extra Docker driver), you need to mount them on the same `base path` and indicate this name on `Volume Driver / Path` section.
Moreover, you need to use the same disk name with a number as suffix (from 0 to 4) and report this on `Disk base name` section.

For example, if you should to use 4 disks per nodes:
- Number of disks per node: 4
- Volume driver / Path: /data/minio
- Disk base name: disk

And you have to mount the following partition:
- /data/minio/disk0
- /data/minio/disk1
- /data/minio/disk2
- /data/minio/disk3
- 

To more info about nodes and disks, you can read the [official documentation](https://github.com/minio/minio/tree/master/docs/distributed)



### Advance info
1. This template create first the container called `rancher-cattle-metadata`. It embedded confd, with some scripts to get many settings from Cattle scheduler and expose them through the volume.
2. Then, the template create `minio` container. It will launch the scripts provided from `rancher-cattle-metadata` container with `volumes_from`. it will create /opt/scheduler/conf/scheduler.cfg file with some usefull infos about container, service, stack and host. Next,  it will source `/opt/scheduler/conf/scheduler.cfg` and launch confd scripts to configure minio.

### Source, bugs and enhances

 If you found bugs or need enhance, you can open ticket on github:
 - [Minio official core project](https://github.com/minio/minio)
 - [Minio docker image](https://github.com/mschneider82/alpine-minio)
 - [Rancher Cattle metadata docker image](https://github.com/disaster37/rancher-cattle-metadata)
