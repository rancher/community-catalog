version: '2'
services:
  agent:
    image: drone/agent:${drone_version}
    environment:
      DRONE_SERVER: ${drone_server}
      DRONE_SECRET: ${drone_secret}
{{- if (.Values.http_proxy)}}
      HTTP_PROXY: ${http_proxy}
      http_proxy: ${http_proxy}
{{- end}}
{{- if (.Values.https_proxy)}}
      HTTPS_PROXY: ${https_proxy}
      https_proxy: ${https_proxy}
{{- end}}
{{- if (.Values.no_proxy)}}
      NO_PROXY: ${no_proxy}
      no_proxy: ${no_proxy}
{{- end}}
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    links:
      - server:drone
    command:
      - agent
    labels:
      io.rancher.scheduler.affinity:container_label_soft_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
      io.rancher.container.hostname_override: container_name
  server:
    image: drone/drone:${drone_version}
    environment:
      DRONE_HOST: ${drone_host}
      GIN_MODE: ${gin_mode}
{{- if (.Values.drone_debug)}}
      DRONE_DEBUG: '${drone_debug}'
{{- end}}
      DRONE_SECRET: ${drone_secret}
      DRONE_OPEN: ${drone_open}
{{- if (.Values.drone_admin)}}
      DRONE_ADMIN: ${drone_admin}
{{- end}}
{{- if (.Values.drone_orgs)}}
      DRONE_ORGS: ${drone_orgs}
{{- end}}
{{- if eq .Values.drone_driver "GitHub"}}
      DRONE_GITHUB: true
      DRONE_GITHUB_CLIENT: ${drone_driver_client}
      DRONE_GITHUB_SECRET: ${drone_driver_secret}
{{- end}}
{{- if eq .Values.drone_driver "Bitbucket Cloud"}}
      DRONE_BITBUCKET: true
      DRONE_BITBUCKET_CLIENT: ${drone_driver_client}
      DRONE_BITBUCKET_SECRET: ${drone_driver_secret}
{{- end}}
{{- if eq .Values.drone_driver "Bitbucket Server"}}
      DRONE_STASH: true
      DRONE_STASH_GIT_USERNAME: ${drone_driver_user}
      DRONE_STASH_GIT_PASSWORD: ${drone_driver_password}
      DRONE_STASH_CONSUMER_KEY: ${drone_driver_client}
      DRONE_STASH_CONSUMER_RSA_STRING: ${drone_driver_secret}
      DRONE_STASH_URL: ${drone_driver_url}
{{- end}}
{{- if eq .Values.drone_driver "GitLab"}}
      DRONE_GITLAB: true
      DRONE_GITLAB_CLIENT: ${drone_driver_secret}
      DRONE_GITLAB_SECRET: ${drone_driver_secret}
      DRONE_GITLAB_URL: ${drone_driver_url}
{{- end}}
{{- if eq .Values.drone_driver "Gogs"}}
      DRONE_GOGS: true
      DRONE_GOGS_URL: ${drone_driver_url}
{{- end}}
{{- if ne .Values.database_driver "sqlite"}}
      DRONE_DATABASE_DRIVER: ${database_driver}
      DRONE_DATABASE_DATASOURCE: ${database_source}
{{- end}}
{{- if (.Values.http_proxy)}}
      HTTP_PROXY: ${http_proxy}
      http_proxy: ${http_proxy}
{{- end}}
{{- if (.Values.https_proxy)}}
      HTTPS_PROXY: ${https_proxy}
      https_proxy: ${https_proxy}
{{- end}}
{{- if (.Values.no_proxy)}}
      NO_PROXY: ${no_proxy}
      no_proxy: ${no_proxy}
{{- end}}
    labels:
      io.rancher.scheduler.affinity:container_label_soft_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
      io.rancher.container.hostname_override: container_name
{{- if eq .Values.database_driver "sqlite"}}
      io.rancher.sidekicks: server-volume
    volumes_from:
      - server-volume
  server-volume:
    image: rawmind/alpine-volume:0.0.2-1
    environment:
      SERVICE_GID: '0'
      SERVICE_UID: '0'
      SERVICE_VOLUME: /var/lib/drone
    network_mode: none
    volumes:
      - /var/lib/drone
    labels:
      io.rancher.container.start_once: 'true'
      io.rancher.scheduler.affinity:container_label_soft_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
      io.rancher.container.hostname_override: container_name
{{- end}}
  lb:
    image: rancher/lb-service-haproxy:v0.6.4
    ports:
      - ${host_port}:${host_port}
    labels:
      io.rancher.scheduler.global: 'true'
      io.rancher.scheduler.affinity:host_label_soft: ${drone_lb_host_label}
