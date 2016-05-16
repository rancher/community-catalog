# Percona XtraDB Cluster

### Info:

This template creates a Percona XtraDB Cluster on top of Rancher.

When deployed from the catalog, a three node cluster is created with a database, root password, database user and password. The cluster is set up for replication between all of the nodes. Health check monitors port 8000 for clustercheck status updates.

### Usage:

Once deployed, use a mysql client to connect:

`mysql -u<db_user> -p -h<pxc>`