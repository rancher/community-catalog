## GlusterFS (Experimental)

### Info:

This creates a 3 node GlusterFS cluster with a single replicated volume. The volume can be used within the Rancher Managed network, or exposed through the host to clients outside of Rancher. You can add additional nodes to the Gluster cluster, but they will not be added to the original volume pool. 

Once created, this stack takes a hands off approach to managing Glusterfs. The only exception is that new instances will be added to the Gluster pool, but not added to the volume. Users are expected to manage GlusterFS.

### Pre-reqs

##### Rancher Managed Network: None

##### Host Networking:
  
  * 3x Nodes - The Gluster Daemon will be listening on the host IP, and it will have port conflict if more then one instance is running on the same host.
  
  * Every host needs the following ports open to each other and clients: 
    * 24007
	* 24007/udp
    * 24008
    * 24008/udp
    * 49152
    * ICMP
    
   * DNS needs to resolve for the GlusterFS server nodes between each server node and the clients.
 
### Usage  

Select the GlusterFS app from the Rancher Catalog. By default, the volume name will be my_vol, but you can update the volume name before creation. 

You will also need to select the network mode. The choices are 'container:glusterfs-server' and 'host'. To run GlusterFS for use with Convoy or just over the Rancher managed network, select the 'container:glusterfs-server' option. If you want to run GlusterFS for clients outside of Rancher, and are running on a secure network, select the host networking mode. 
   
### Mounting

If mounting inside of another container on the network, the client container will need be launched on a host with the fuse kernel module and have `--device=/dev/fuse:/dev/fuse` and at least `--cap_add=SYS_ADMIN`. (On Ubuntu hosts there is an issue with AppArmor that requires `--privileged`)

On the Rancher Managed Network, you are able to mount via the containers IP addresses. 

On the host network mode, mount the volume via the hostnames.

   
        