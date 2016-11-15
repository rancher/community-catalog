# Heapster Grafana InfluxDB

Heapster enables Container Cluster Monitoring and Performance Analysis. Heapster collects and interprets various signals like compute resource usage, lifecycle events, etc, and exports cluster metrics via REST endpoints.

This Tempalte runs Heapster with Grafana and InfluxDB in kube-system namespace, it should be running on Kubernetes v1.3.4-rancher1 or higher.
