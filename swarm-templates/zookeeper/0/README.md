# Zookeeper

ZooKeeper is a centralized service for maintaining configuration information, naming, providing distributed synchronization, and providing group services. Visit the [Official Site](https://zookeeper.apache.org/).

### Usage

This is a standalone Zookeeper deployment suitable for development and testing purposes. As such, there is not much to configure.

Once deployed, you may inspect Zookeeper information with the `zk-cli` command. If deployment was successful, you'll see something similar to this:

```
$ zk-cli
Connecting to localhost:2181
Welcome to ZooKeeper!
JLine support is enabled

WATCHER::

WatchedEvent state:SyncConnected type:None path:null
[zk: localhost:2181(CONNECTED) 0]
```