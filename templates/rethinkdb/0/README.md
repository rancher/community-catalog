# RethinkDB Cluster
RethinkDB is the first open-source, scalable JSON database built from the ground up for the realtime web. It inverts the traditional database architecture by exposing an exciting new access model – instead of polling for changes, the developer can tell RethinkDB to continuously push updated query results to applications in realtime. RethinkDB’s realtime push architecture dramatically reduces the time and effort necessary to build scalable realtime apps.


**This Template creates 2 services:**
- **rethinkdb:** This is the scalable database service.
- **rethinkdb-proxy:** This is the proxy service, the query-router and admin panel. (queries are sent to this service)


### Repository
https://github.com/xkodiak/rancher-rethinkdb

### Variables
- **Proxy Web Port:** admin panel port (default: 8080)
- **Proxy Query Port:** query port (default: 28015)
- **Volume Driver:** local, rancher-nfs, ... (default: local)

