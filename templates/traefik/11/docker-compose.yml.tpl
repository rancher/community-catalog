version: '2'
services:
  traefik:
    ports:
    - ${admin_port}:8000/tcp
    - ${http_port}:${http_port}/tcp
    - ${https_port}:${https_port}/tcp
    labels:
      io.rancher.scheduler.global: 'true'
      io.rancher.scheduler.affinity:host_label: ${host_label}
      io.rancher.scheduler.affinity:container_label_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
    {{- if or (eq .Values.rancher_integration "external") (eq .Values.acme_enable "true")}}
      io.rancher.sidekicks: 
        {{- if eq .Values.rancher_integration "external"}} traefik-conf
            {{- if eq .Values.acme_enable "true" -}},{{- end -}}
        {{- end -}}
        {{- if eq .Values.acme_enable "true" -}}
            {{- if ne .Values.rancher_integration "external"}} traefik-acme
            {{- else -}}traefik-acme
            {{- end -}}
        {{- end -}}
    {{- end}}
      io.rancher.container.hostname_override: container_name
    image: rawmind/alpine-traefik:1.4.0-3
    environment:
    - TRAEFIK_HTTP_PORT=${http_port}
    - TRAEFIK_HTTP_COMPRESSION=${compress_enable}
    - TRAEFIK_HTTPS_PORT=${https_port}
    - TRAEFIK_HTTPS_ENABLE=${https_enable}
    - TRAEFIK_HTTPS_COMPRESSION=${compress_enable}
    - TRAEFIK_INSECURE_SKIP=${insecure_skip}
    - TRAEFIK_ADMIN_ENABLE=true
    - TRAEFIK_ADMIN_READ_ONLY=${admin_readonly}
    - TRAEFIK_ADMIN_STATISTICS=${admin_statistics}
    - TRAEFIK_ADMIN_AUTH_METHOD=${admin_auth_method}
    - TRAEFIK_ADMIN_AUTH_USERS=${admin_users}
  {{- if eq .Values.rancher_integration "external"}}
    - CONF_INTERVAL=${refresh_interval}
  {{- end}}
  {{- if eq .Values.acme_enable "true"}}
    - TRAEFIK_ACME_ENABLE=${acme_enable}
    - TRAEFIK_ACME_EMAIL=${acme_email}
    - TRAEFIK_ACME_ONDEMAND=${acme_ondemand}
    - TRAEFIK_ACME_ONHOSTRULE=${acme_onhostrule}
    - TRAEFIK_ACME_CASERVER="${acme_caserver}"
  {{- end}}
  {{- if ne .Values.rancher_integration "external"}}
    - TRAEFIK_RANCHER_ENABLE=true
    - TRAEFIK_RANCHER_MODE=${rancher_integration}
    {{- if eq .Values.rancher_integration "api"}}
    - CATTLE_URL=${cattle_url}
    - CATTLE_ACCESS_KEY=${cattle_access_key}
    - CATTLE_SECRET_KEY=${cattle_secret_key}
    {{- end}}
  {{- end}}
  {{- if eq .Values.prometheus_enable "true"}}
    - TRAEFIK_PROMETHEUS_ENABLE=${prometheus_enable}
    - TRAEFIK_PROMETHEUS_BUCKETS=${prometheus_buckets}
  {{- end}}
  {{- if or (eq .Values.rancher_integration "external") (eq .Values.acme_enable "true")}}
    volumes_from:
    {{- if eq .Values.rancher_integration "external"}}
    - traefik-conf
    {{- end}}
    {{- if eq .Values.acme_enable "true"}}
    - traefik-acme
    {{- end}}
  {{- end}}
  {{- if eq .Values.rancher_integration "external"}}
  traefik-conf:
    labels:
      io.rancher.scheduler.global: 'true'
      io.rancher.scheduler.affinity:host_label: ${host_label}
      io.rancher.scheduler.affinity:container_label_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
      io.rancher.container.start_once: 'true'
    image: rawmind/rancher-traefik:1.3.6
    network_mode: none
    volumes:
      - tools-volume:/opt/tools
  {{- end}}
  {{- if eq .Values.acme_enable "true"}}
  traefik-acme:
    network_mode: none
    labels:
      io.rancher.scheduler.affinity:container_label_soft_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
      io.rancher.container.hostname_override: container_name
      io.rancher.container.start_once: true
    environment:
      - SERVICE_UID=10001
      - SERVICE_GID=10001
      - SERVICE_VOLUME=/opt/traefik/acme
    volumes:
      - ${acme_vol_name}:/opt/traefik/acme
    image: rawmind/alpine-volume:0.0.2-1
  {{- end}}
{{- if or (eq .Values.rancher_integration "external") (eq .Values.acme_enable "true")}}
volumes:
  {{- if eq .Values.rancher_integration "external"}}
  tools-volume:
    driver: local
    per_container: true
  {{- end}}
  {{- if eq .Values.acme_enable "true"}}
  ${acme_vol_name}:
    driver: ${acme_vol_driver}
  {{- end}}
{{- end}}
