traefik:
  ports:
  - ${admin_port}:8000/tcp
  - ${http_port}:${http_port}/tcp
  - ${https_port}:${https_port}/tcp
  log_driver: ''
  labels:
    io.rancher.scheduler.global: 'true'
    io.rancher.scheduler.affinity:host_label: ${host_label}
    io.rancher.scheduler.affinity:container_label_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
    io.rancher.sidekicks: traefik-conf
      {{- if eq .Values.acme_enable "true" -}}
        ,traefik-acme
      {{- end}}
    io.rancher.container.hostname_override: container_name
  tty: true
  log_opt: {}
  image: rawmind/alpine-traefik:1.3.3
  environment:
  - CONF_INTERVAL=${refresh_interval}
  - TRAEFIK_HTTP_PORT=${http_port}
  - TRAEFIK_HTTPS_PORT=${https_port}
  - TRAEFIK_HTTPS_ENABLE=${https_enable}
{{- if eq .Values.acme_enable "true"}}
  - TRAEFIK_ACME_ENABLE=${acme_enable}
  - TRAEFIK_ACME_EMAIL=${acme_email}
  - TRAEFIK_ACME_ONDEMAND=${acme_ondemand}
  - TRAEFIK_ACME_ONHOSTRULE=${acme_onhostrule}
{{- end}}
  - TRAEFIK_INSECURE_SKIP=${insecure_skip}
  volumes_from:
  - traefik-conf
{{- if eq .Values.acme_enable "true"}}
  - traefik-acme
{{- end}}
traefik-conf:
  log_driver: ''
  labels:
    io.rancher.scheduler.global: 'true'
    io.rancher.scheduler.affinity:host_label: ${host_label}
    io.rancher.scheduler.affinity:container_label_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
    io.rancher.container.start_once: 'true'
  tty: true
  log_opt: {}
  image: rawmind/rancher-traefik:1.3.3-1
  net: none
  volumes:
    - /opt/tools
{{- if eq .Values.acme_enable "true"}}
traefik-acme:
  net: none
  labels:
    io.rancher.scheduler.affinity:container_label_soft_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
    io.rancher.container.hostname_override: container_name
    io.rancher.container.start_once: true
  environment:
    - SERVICE_UID=10001
    - SERVICE_GID=10001
    - SERVICE_VOLUME=/opt/traefik/acme
  volumes:
    - ${VOLUME_NAME}:/opt/traefik/acme
  volume_driver: ${VOLUME_DRIVER}
  image: rawmind/alpine-volume:0.0.2-1
{{- end}}
