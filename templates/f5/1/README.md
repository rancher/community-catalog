# F5 BIG-IP 

### Info:

By integrating with F5 BIG-IP, you add the ability to load balance services regardless of which hosts the containers have been deployed on. Currently, we only support an unpartitioned F5 BIG-IP installation. Prior to adding the service, please make sure the VirtualServer is configured on F5. 

After launching the F5 service, services in Rancher will be registered to the F5 BIG-IP if it meets the following conditions:

* Exposes a public port on the host

* Contains a label with a key of 'io.rancher.service.external_lb_endpoint' and a value of the VirtualServer Name on F5 BIG-IP

In F5, any Rancher host running services that meet the criteria will be added to the F5 setup as nodes. For each service, a F5 pool will be created and each host that runs the service will be added as a pool member (`<host_ip>:<exposed_port>`).  In the pool, the name of the pool member will be `<service_name>_<environment_uuid>_rancher.internal`. You can configure the suffix of the names. By default, this is set as `rancher.internal`.

Once the F5 configuration has been completed, you can access any services in Rancher using the F5 `<vip>:<port>`. As services matching the criteria are added and removed from Rancher, the F5 service will sync with the F5 BIG-IP will all the changes. 