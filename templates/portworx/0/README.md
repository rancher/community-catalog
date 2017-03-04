# [1.1.6-GA Documentation](http://docs.portworx.com)

This catalog will spin up Portworx on your hosts.
There are 2 configuration variables required:
 1. **cluster_id**:  Arbitrary Cluster ID, common to all nodes in PX cluster.  (Can use https://www.uuidgenerator.net for example)
 2. **kvdb**:  A Key-value database that is accessible to all nodes in the PX cluster.  (Ex: etcd://10.0.0.42:4001)
 3. **header_dir**: The directory where kernel headers can be found.  Default is "/usr/src".  For CoreOS use "/lib/modules"
 4. **use_disks**: The list of devices to use as part of the cluster fabric. (Ex: '-a' for all disks, or '-s /dev/sdX' for each individual disk)

**NOTE**: px-dev requires at least one non-root disk be attached to the running image (i.e local disk or iscsi).

**NOTE**: If using Docker prior to 1.12, then you **MUST** remove 'MOUNT=shared' from the docker.service file and restart the docker service.

For detailed documentation, please visit [docs.portworx.com](http://docs.portworx.com)

For the Portworx Enterprise edition which has support for a larger number of nodes, enterprise features such as cloud native encryption, monitoring and web UI, contact support@portworx.com

