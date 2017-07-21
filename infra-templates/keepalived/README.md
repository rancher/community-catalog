## Keepalived
Manages VRRP failover within Rancher. 

This is useful for highly available load balancers or other HA services that you can't load balance.

### Form Fields

| Variable          | Description                              |
| ----------------- | ---------------------------------------- |
| Host Label        | Host Label used to schedule keepalived master and backup instances |
| Master Host Label | Keepalived Host Label to signifify the master instance |
| Backup Host Label | Keepalived Host Label to signifify the backup instance |
| Master IP         | Host IP of master edge node              |
| Backup IP         | Host IP of backup edge node              |
| Virtual IP        | Virtual IP to be created                 |

### Advanced Usage

This service is intended to be deployed to edge nodes with a MASTER and BACKUP deployed respectively.
Additional IPs should be managed via environment variables once deployed with entries following the below pattern:

`KEEPALIVED_VIRTUAL_IPADDRESS_[0-9]{1,3}`

Format should mimic the ip command
`10.255.33.100/24 dev eth0`