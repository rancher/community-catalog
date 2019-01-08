version: '2'
services:
  traefik:
    ports:
    - ${admin_port}:${admin_port}/tcp
    - ${http_port}:${http_port}/tcp
  {{- if ne .Values.https_enable "false"}}
    - ${https_port}:${https_port}/tcp
  {{- end}}
    labels:
      io.rancher.scheduler.global: 'true'
      io.rancher.scheduler.affinity:host_label: ${host_label}
      io.rancher.scheduler.affinity:container_label_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
    {{- if eq .Values.rancher_integration "api"}}
      io.rancher.container.agent.role: environment
      io.rancher.container.create_agent: 'true'
    {{- end}}
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
    image: rawmind/alpine-traefik:1.7.6-0
    environment:
    - TRAEFIK_HTTP_PORT=${http_port}
    - TRAEFIK_HTTP_COMPRESSION=${compress_enable}
    - TRAEFIK_HTTPS_PORT=${https_port}
    - TRAEFIK_HTTPS_ENABLE=${https_enable}
    - TRAEFIK_HTTPS_COMPRESSION=${compress_enable}
    - TRAEFIK_USAGE_ENABLE=${usage_enable}
    - TRAEFIK_TIMEOUT_READ=${timeout_read}
    - TRAEFIK_TIMEOUT_WRITE=${timeout_write}
    - TRAEFIK_TIMEOUT_IDLE=${timeout_idle}
    - TRAEFIK_TIMEOUT_DIAL=${timeout_dial}
    - TRAEFIK_TIMEOUT_HEADER=${timeout_header}
  {{- if ne .Values.https_min_tls ""}}
    - TRAEFIK_HTTPS_MIN_TLS=${https_min_tls}
  {{- end}}
  {{- if ne .Values.trusted_ips ""}}
    - TRAEFIK_TRUSTEDIPS=${trusted_ips}
  {{- end}}
  {{- if ne .Values.ssl_key ""}}
    - TRAEFIK_SSL_KEY=${ssl_key}
  {{- end}}
  {{- if ne .Values.ssl_crt ""}}
    - TRAEFIK_SSL_CRT=${ssl_crt}
  {{- end}}
    - TRAEFIK_INSECURE_SKIP=${insecure_skip}
    - TRAEFIK_ADMIN_ENABLE=true
    - TRAEFIK_ADMIN_PORT=${admin_port}
    - TRAEFIK_ADMIN_SSL=${admin_ssl}
    - TRAEFIK_ADMIN_STATISTICS=${admin_statistics}
    - TRAEFIK_ADMIN_AUTH_METHOD=${admin_auth_method}
    - TRAEFIK_ADMIN_AUTH_USERS=${admin_users}
  {{- if eq .Values.acme_enable "true"}}
    - TRAEFIK_ACME_ENABLE=${acme_enable}
    - TRAEFIK_ACME_EMAIL=${acme_email}
    - TRAEFIK_ACME_CHALLENGE=${acme_challenge}
    - TRAEFIK_ACME_CHALLENGE_HTTP_ENTRYPOINT=http
    - TRAEFIK_ACME_ONHOSTRULE=${acme_onhostrule}
    - TRAEFIK_ACME_CASERVER=${acme_caserver}
    - TRAEFIK_ACME_KEYTYPE=${acme_keytype}
  {{- end}}
  {{- if ne .Values.rancher_integration "external"}}
    - TRAEFIK_RANCHER_ENABLE=true
    - TRAEFIK_FILE_ENABLE=false
    - TRAEFIK_CONSTRAINTS=${constraints}
    - TRAEFIK_RANCHER_HEALTHCHECK=${rancher_healthcheck}
    - TRAEFIK_RANCHER_MODE=${rancher_integration}
  {{- else}}
    - TRAEFIK_FILE_ENABLE=true
  {{- end}}
  {{- if eq .Values.metrics_enable "true"}}
    - TRAEFIK_METRICS_ENABLE=${metrics_enable}
    - TRAEFIK_METRICS_EXPORTER=${metrics_exporter}
    - TRAEFIK_METRICS_PUSH=${metrics_push}
    - TRAEFIK_METRICS_ADDRESS=${metrics_address}
    - TRAEFIK_METRICS_PROMETHEUS_BUCKETS=${metrics_prometheus_buckets}
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
    image: rawmind/rancher-traefik:1.6.0-0
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
    image: rawmind/alpine-volume:0.0.2-3
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
