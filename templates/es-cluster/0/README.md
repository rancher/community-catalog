# Elasticsearch Cluster

A scalable Elasticsearch cluster

## Notes

You have to set vm.max_map_count to atleast 262144 on each of the hosts that will run Elasticsearch!

To do so run `sudo sysctl -w vm.max_map_count=262144`