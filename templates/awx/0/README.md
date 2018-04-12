# AWX #

### Info:

AWX provides a web-based user interface, REST API, and task engine built on top of Ansible. It is the upstream project for Tower, a commercial derivative of AWX.

The template is designed to be flexible in how you configure it; you can either statically bind AWX to existing stack components (PostgreSQL, Memcached, and RabbitMQ), or or let the catalog item install stack-scoped versions of them for you.

This catalog item uses these six main containers:
* [AWX](https://github.com/ansible/awx) - The official AWX Github Repository (awx_task and awx_web)
* [Memcached](https://memcached.org/) - A distributed memory object cache
* [RabbitMQ](https://www.rabbitmq.com/) - An open-source message broker
* [PostgreSQL](https://www.postgresql.org/) - An open-source sql database
* [Rancher LoadBalancer](https://hub.docker.com/r/rancher/lb-service-haproxy/) - Rancher's own official HAProxy load balancer

## Deployment:
1. Select the catalog item and choose a version from the drop-down box
2. Adjust any values on the page to meet your needs.
   * It is HIGHLY recommended that you set a unique security key (such as uuidgen, or some other alternative) to ensure your AWX server won't be hijacked by unscrupulous people... you have been warned.
   * Such as whether or not you want to use pre-installed tools from other stacks:
     * Memcached
     * PostgreSQL
     * RabbitMQ
   * -Or- Let this catalog item install them for you locally scoped in the same stack
4. Specify a volume driver for persistent storage of all stack's data
5. Finally, once the stack is up, you can use your normal AWX process (the web gui) to configure and set up your new AWX server.
6. Enjoy!


