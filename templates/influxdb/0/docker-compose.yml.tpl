version: '2'
services:
{{- if eq .Values.EXPOSE_SERVICE "true"}}
  lb:
    image: rancher/lb-service-haproxy:v0.6.2
    ports:
    - ${influxdb_port}:8086/tcp
    labels:
      io.rancher.container.agent.role: environmentAdmin
      io.rancher.container.create_agent: 'true'
{{- end}}
  influxdb:
    image: influxdb:1.2.2-alpine
    stdin_open: true
    tty: true
    labels:
      io.rancher.scheduler.affinity:container_label_soft_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
      io.rancher.container.hostname_override: container_name
      io.rancher.sidekicks: influxdb-volume
    volumes_from:
      - influxdb-volume
  influxdb-volume:
    network_mode: "none"
    labels:
      io.rancher.scheduler.affinity:container_label_soft_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
      io.rancher.container.hostname_override: container_name
      io.rancher.container.start_once: true
    environment:
      - SERVICE_UID=0
      - SERVICE_GID=0
      - SERVICE_VOLUME=/var/lib/influxdb
    volumes:
      - /var/lib/influxdb
    volume_driver: local
    image: rawmind/alpine-volume:0.0.2-1

