## Keepalived
Manages VRRP failover

### Usage

This service is intended to be deployed to edge nodes with a MASTER and BACKUP deployed respectively.
Additional IPs should be managed via environment variables once deployed with entries following the below pattern:

`KEEPALIVED_VIRTUAL_IPADDRESS_[0-9]{1,3}`

Format should mimic the ip command
`10.255.33.100/24 dev eth0`
