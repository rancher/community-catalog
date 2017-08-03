# Keepalived

This catalog recipe enables unicast VRRP based failover for one or more floating IP Addresses. It's intended deployment is for use on a pair edge or ingress nodes where forward-facing load-balancers or other like services will be scheduled.


### Form Fields
* **Update Host Sysctl** - If `true` automatically sets the needed sysctl setting on the host.
* **Host Label Name** - Host label key name used to schedule keepalived master and backup instances.
* **Master Label** - The value of the keepalived host Label to signify the master instance.
* **Backup Label** - The value of the keepalived host Label to signify the backup instance.
* **Interface Name** - The host interface that keepalived will monitor and use for VRRP traffic.
* **Virtual Router ID** -  A unique number from 0 to 255 that should identify the VRRP group.
* **Master IP** - The IP on the master host that the keepalived daemon should bind to.
* **Backup IP** - The IP on the backup host that the keepalived daemon should bind to.
* **Virtual IP** - Virtual IP to be created. Must be in ip notation: `<ipaddress>/<mask> dev <interface>`

### Requirements

The host must have the sysctl setting `net.ipv4.ip_nonlocal_bind=1` configured.

### Usage

This service is intended to be deployed to edge nodes with a `master` and `backup` deployed respectively. One or more Virtual IPs may then be bound to hosts. These hosts should have an additional label used for load-balancer scheduling e.g. `ingress=true`

#### Adding an HA Load Balancer Service

**Ensure your edge hosts have an additional host label before proceeding**

1. From the Stack menu add a new `Load Balancer`.
2. Set `Scale` to be `Always run one instance of this container on every host`.
3. Add an appropriate `Name` and `Description`.
4. In the `Port Rules` section, click `Show host IP address options.` This enables the Host IP Field.
5. Update the `Port Rules` with the `Host IP` field set to your `Virtual IP` as defined in the keepalived config. Configure the rest of the fields as needed for your application.
6. Click on the `Scheduling` tab and click on `Add Scheduling Rule`.
7. Create a rule where "The host `must` have a `host label` of `<edge node host label>` = `<edge node host label value>`.
8. Click Create.

#### Adding additional Virtual IPs to the keepalived Service

1. From the Stack menu expand the `keepalived` service.
2. Select upgrade on the `keepalived-backup` service.
3. Add a new Environment Variable called `KEEPALIVED_VIRTUAL_IPADDRESS_<number>`. Where `<number>` should be a unique value from 0-999. e.g. `KEEPALIVED_VIRTUAL_IPADDRESS_2`.
4. Set the value to be a **QUOTED STRING** with an additional virtual IP following the standard ip format of `<ipaddress>/<mask> dev <interface>`. e.g. `10.255.33.102/24 dev eth0`.
5. Press `Upgrade`.
6. Repeat the same steps for the `keepalived-master` service.


### Troubleshooting

For further help see the main [arc-ts/keepalived git repo](https://github.com/arc-ts/keepalived)