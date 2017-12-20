# Nsq.io

### Info:

This template creates, scale in and scale out a nsqd cluster on top of Rancher. By default there are 3 static nsqlookupd provisioned.
NSQD (TCP/4150, HTTP/4151) and the webinterface nsqadmin (HTTP/4171) can be reached by using the provisioned nsq-lb loadbalancer.

### Service configuration labels:

You can control where nsqd, nsqadmin, nsqlookupd and nsq-lb will be deployed by setting the following host labels:

- nsqd = <true | false>•
- nsqlookupd = <true | false>•
- nsqadmin = <true | false>•
- nsq-lb = <true | false>•

### Usage:

Select NSQ from catalog.

Enter the number of nodes for your NSQD cluster and NSQ Admin instances.

Click deploy.
