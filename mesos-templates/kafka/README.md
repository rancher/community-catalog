# Kafka Mesos Framework

Kafka framework doesn't support Docker executors, so your Mesos Slaves must have `java` installed.

There is also no GUI. The CLI is wrapped for your convenience, and may be used from within the scheduler container:

```bash
root@5a466883dda2:/# kafka broker add 0..1 --cpus 0.1 --heap 256 --mem 384
brokers added:
  id: 0
  active: false
  state: stopped
  resources: cpus:0.10, mem:384, heap:256, port:auto
  failover: delay:1m, max-delay:10m
  stickiness: period:10m

  id: 1
  active: false
  state: stopped
  resources: cpus:0.10, mem:384, heap:256, port:auto
  failover: delay:1m, max-delay:10m
  stickiness: period:10m

root@5a466883dda2:/# kafka broker start 0..1
brokers started:
  id: 0
  active: true
  state: running
  resources: cpus:0.10, mem:384, heap:256, port:auto
  failover: delay:1m, max-delay:10m
  stickiness: period:10m, hostname:192.168.99.108
  task:
    id: broker-0-899d16d4-00bb-445a-8f57-95464640413f
    state: running
    endpoint: 192.168.99.108:31000
  metrics:
    collected: 2016-04-21 23:35:24Z
    under-replicated-partitions: 0
    offline-partitions-count: 2
    is-active-controller: 1

  id: 1
  active: true
  state: running
  resources: cpus:0.10, mem:384, heap:256, port:auto
  failover: delay:1m, max-delay:10m
  stickiness: period:10m, hostname:192.168.99.108
  task:
    id: broker-1-97d19b5e-6d2b-4f15-8c49-abc217aac9a9
    state: running
    endpoint: 192.168.99.108:31001
```
