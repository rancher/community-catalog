# QuasarDB Community

Version: 2.0.0-rc8

### Known limitations for this Rancher catalog entry

 * So far, the community edition is limited to a two node cluster with 2GB of resident memory and a maximum of 16GB of persisted data per node. (So 32GB of data with a replication factor set to 1, and 16GB of data with a replciation factor set to 2)

 *  QuasarDB need to listen on a specific IP adress or network interface and cannot listen on 0.0.0.0/0 for security reasons. The workaround used by this catalog entry, is to use the --network=host option of Docker and to listen on the network device you need (eth0, enp1s0f0, etc.).
 * QuasarDB performances are node ID related, therefore the catalog entry will create one service per node, to ensure using the right ID to get best performances.
 * You cannot scale-out QuasarDB Community catalog entry beacause of the previous limitation. This is not a real limitation for now, because the community edition dosn't allow more than 2 nodes in a cluster.

### WHAT IS QUASARDB?

quasardb is the answer to problems faced by companies in today’s world of big and fast data. It is the missing link between file systems and databases: a data backend that can be accessed directly by your application or through other technologies (such as relational or in-memory databases).

Its speed, scalability and flexibility makes it extremely relevant for big data, finance, ad exchange and gaming.

- Raw power and convenience of file systems.
- Transactional, distributed and indexable, like a database.
- Can be used directly by applications or as a backend of other systems such as relational databases, NoSQL databases or in-memory databases.

### A DISTRIBUTED KEY-VALUE STORE

At the heart of quasardb is an unique distributed key-value store technology. It scales horizontally and vertically for virtually unlimited capabilities. All of this, without any compromise regarding reliability and consistency.

- Peer-to-peer distribution based on the Chord algorithm
- Lockfree and multithreaded code for vertical scaling
- Implementation in modern C++ for maximum efficiency

### ADVANCED TYPES

You can store raw data of any form and size into quasardb, but should you need to, you can also do atomic operations on integers, manipulate queues and sets. Quasardb takes away all the hard problems such as concurrent access, reliable distribution and efficient operations.

- Best of breed memory management technology to handle very large entries (hundreds of megabytes large)
- Atomic and concurrent operations on integers
- Distributed queues and sets, share data structures amongst your programs!

### TRANSACTIONS

How to manipulate several entries at once in a consistent fashion? Quasardb comes out of the box with distributed transactions. Transactions enable you to execute commands on several entries in a safe, predictable, consistent manner.

- Distributed transactions based on Multi Version Concurrency Control (MVCC)
- Unlimited read scalability
- No global lock: transactions can work in parallel on different entries

### TAGGING AND REAL-TIME SEARCH

How to find your entry when you don’t have its key? The typical solution is to create a schema and perform queries based on this schema. Quasardb has a better, schema-less approach: tags. Tags are extremely fast and scale automatically. Don’t compromise between search and speed: just tag!

- Distributed tags for flexible data management
- Immediate tag-based lookup
- Tags can be removed or renamed

### FAULT TOLERANCE

Quasardb is write-safe by default and offers features to sync absolutely everything you do for maximum safety. Thanks to its master-less design, quasardb is able to face the loss of nodes transparently. When a node joins back, quasardb will replay the log of events to guarantee consistency.

- Fault-tolerant by design: perfectly symmetric peer-to-peer architecture
- Safe by default
- MVCC, high-resolution timestamps and the Chord algorithm are used together to guarantee consistency
