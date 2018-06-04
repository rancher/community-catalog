consul-base:
  image: consul:0.8.1
  entrypoint:
    - /opt/rancher/bin/start_consul.sh
  net: "container:consul"
  labels:
    io.rancher.container.hostname_override: container_name
  volumes_from:
    - consul-data
consul-data:
  image: alpine:latest
  entrypoint:
    - /bin/true
  labels:
    io.rancher.container.hostname_override: container_name
    io.rancher.container.start_once: true
  volumes:
    - /var/consul
    - /opt/rancher/bin
    - /opt/rancher/ssl
    - /opt/rancher/config
  net: none
consul:
  image: husseingalal/consul-config:0.1.2
  labels:
    io.rancher.container.hostname_override: container_name
    io.rancher.sidekicks: consul-base,consul-data
  volumes_from:
    - consul-data
{{- if eq .Values.ui "true"}}
consul-lb:
  ports:
  - 8500:8500/tcp
  expose:
  - 8500:8500/tcp
  tty: true
  image: rancher/load-balancer-service
  links:
  - consul:consul-base
  stdin_open: true
{{- end }}
