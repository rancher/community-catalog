# Prometheus

### Info:

This template deploys a collection of containers based upon the technologies below, once deployed you should have a monitoring platform capable of querying all aspects of your environment with some nice pre-built dashboards. 
In this deployment the following technologies are utilised to make this as useful as possible.
* **Prometheus** - Used to scrape and store metrics from our data sources. (https://github.com/prometheus/prometheus)
* **Prometheus Node Exporter** - Gets host level metrics and exposes them to Prometheus. (https://github.com/prometheus/node_exporter)
* **Ranch-Eye** - Pre-configured lightwieght haproxy to expose the cadvsior stats used by Rancher's agent container, to Prometheus. (https://github.com/Rucknar/ranch-eye)
* **Grafana** - Used to visualise the data from Prometheus and InfluxDB. (https://github.com/grafana/grafana/)
* **InfluxDB** - Used as database for storing rancher server metrics that rancher exports via the graphite connector. (https://github.com/influxdata/influxdb)
* **rancher-api-integration** - Allows Prometheus to access the Rancher API and return the status of any stack or service in the rancher environment associated with the API key used.(https://github.com/Limilo/prometheus-rancher-exporter/)

To get the full compliment of metrics available,you need to configure the Rancher `graphite.host` address. This can be done automatically when you deploy the template by choosing the option below, for more information or how to do this change manually,see the following [guide](https://github.com/Rucknar/Guide_Rancher_Monitoring)

All components in this stack are open source tools available in the community. All this template does is to bound them together in an easy to use package.
I expect most people who find this useful will make use of this as a starting point and develop it further around their own needs.
 
## Deployment:
* Select Prometheus from the community catalog.
* Click deploy.

## Usage
* Grafana will now be available on, running on port 3000. I've added a number of dashboards to help get you started. Authentication is with the default `admin/admin`.
* Prometheus will now be available, running on port 9090. Have a play around with some of the data. For more information on Prometheus - https://prometheus.io/docs/introduction/overview/
