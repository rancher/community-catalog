version: '2'
services:
  {{- if eq .Values.DEPLOY_SERVER "true"}}
  gocd-server:
    tty: true
    image: webcenter/alpine-gocd-server:17.3.0-1
    volumes:
    {{- if eq (printf "%.1s" .Values.VOLUME_DRIVER_SERVER) "/" }}
      - ${VOLUME_DRIVER_SERVER}:/data
    {{- else}}
      - gocd-server-data:/data
    {{- end}}
    environment:
      - GOCD_CONFIG_memory=${GOCD_SERVER_MEMORY}
      - GOCD_CONFIG_agent-key=${GOCD_AGENT_KEY}
      - GOCD_CONFIG_server-url=${GOCD_SERVER_URL}
      - GOCD_USER_${GOCD_USER}=${GOCD_PASSWORD}
      - CONFD_BACKEND=${CONFD_BACKEND}
      - CONFD_NODES=${CONFD_NODES}
      - CONFD_PREFIX_KEY=${CONFD_PREFIX}
      {{- if eq .Values.GOCD_AGENT_PACKAGE "true"}}
      - GOCD_PLUGIN_script-executor=https://github.com/gocd-contrib/script-executor-task/releases/download/0.3/script-executor-0.3.0.jar
      - GOCD_PLUGIN_docker-task=https://github.com/manojlds/gocd-docker/releases/download/0.1.27/docker-task-assembly-0.1.27.jar
      - GOCD_PLUGIN_slack=https://github.com/Vincit/gocd-slack-task/releases/download/v1.3.1/gocd-slack-task-1.3.1.jar
      - GOCD_PLUGIN_docker-pipline=https://github.com/Haufe-Lexware/gocd-plugins/releases/download/v1.0.0-beta/gocd-docker-pipeline-plugin-1.0.0.jar
      - GOCD_PLUGIN_email-notifier=https://github.com/gocd-contrib/email-notifier/releases/download/v0.1/email-notifier-0.1.jar
      - GOCD_PLUGIN_github-notifier=https://github.com/gocd-contrib/gocd-build-status-notifier/releases/download/1.3/github-pr-status-1.3.jar
      - GOCD_PLUGIN_github-scm=https://github.com/ashwanthkumar/gocd-build-github-pull-requests/releases/download/v1.3.3/github-pr-poller-1.3.3.jar
      - GOCD_PLUGIN_maven-repository=https://github.com/1and1/go-maven-poller/releases/download/v1.1.4/go-maven-poller.jar
      - GOCD_PLUGIN_maven-task=https://github.com/ruckc/gocd-maven-plugin/releases/download/0.1.1/gocd-maven-plugin-0.1.1.jar
      - GOCD_PLUGIN_s3-fetch=https://github.com/indix/gocd-s3-artifacts/releases/download/v2.0.2/s3fetch-assembly-2.0.2.jar
      - GOCD_PLUGIN_s3-publish=https://github.com/indix/gocd-s3-artifacts/releases/download/v2.0.2/s3publish-assembly-2.0.2.jar
      - GOCD_PLUGIN_nessus-scan=https://github.com/Haufe-Lexware/gocd-plugins/releases/download/v1.0.0-beta/gocd-nessus-scan-plugin-1.0.0.jar
      - GOCD_PLUGIN_sonar=https://github.com/Haufe-Lexware/gocd-plugins/releases/download/v1.0.0-beta/gocd-sonar-qualitygates-plugin-1.0.0.jar
      - GOCD_PLUGIN_gitlab-auth=https://github.com/gocd-contrib/gocd-oauth-login/releases/download/v2.3/gitlab-oauth-login-2.3.jar
      - GOCD_PLUGIN_google-auth=https://github.com/gocd-contrib/gocd-oauth-login/releases/download/v2.3/google-oauth-login-2.3.jar
      - GOCD_PLUGIN_github-auth=https://github.com/gocd-contrib/gocd-oauth-login/releases/download/v2.3/github-oauth-login-2.3.jar
      {{- end}}
    {{- if and (ne .Values.DEPLOY_LB "true") (.Values.PUBLISH_PORT)}}
    ports:
      - ${PUBLISH_PORT}:8153
    {{- end}}
    labels:
      io.rancher.scheduler.affinity:container_label_soft_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
      io.rancher.container.hostname_override: container_name
    {{- if eq .Values.DEPLOY_LB "true"}}
  lb:
    image: rancher/lb-service-haproxy:v0.6.2
      {{- if (.Values.PUBLISH_PORT)}}
    ports:
      - ${PUBLISH_PORT}:8153/tcp
      {{- else}}
    expose:
      - 8153:8153/tcp
      {{- end}}
    links:
      - gocd-server:gocd-server
    labels:
      io.rancher.container.agent.role: environmentAdmin
      io.rancher.container.create_agent: 'true'
    {{- end}}
  {{- end}}
  {{- if eq .Values.DEPLOY_AGENT "true"}}
  gocd-agent:
    tty: true
    image: webcenter/alpine-gocd-agent:17.3.0-1
    volumes:
    {{- if eq (printf "%.1s" .Values.VOLUME_DRIVER_AGENT) "/"}}
      - ${VOLUME_DRIVER_AGENT}:/data
    {{- else}}
      - gocd-agent-data:/data
    {{- end}}
      - gocd-scheduler-setting:/opt/scheduler
    environment:
      - GOCD_CONFIG_memory=${GOCD_AGENT_MEMORY}
      - GOCD_CONFIG_agent_key=${GOCD_AGENT_KEY}
      - GOCD_CONFIG_agent_resource_docker=${GOCD_AGENT_RESOURCE}
      - DOCKER_HOST=docker-engine:2375
    {{- if eq .Values.DEPLOY_SERVER "true"}}
    links:
      - gocd-server:gocd-server
    {{- end}}
    labels:
      io.rancher.scheduler.affinity:container_label_soft_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
      io.rancher.container.hostname_override: container_name
      io.rancher.container.agent.role: environment
      io.rancher.container.create_agent: 'true'
      io.rancher.sidekicks: rancher-cattle-metadata,docker-engine
  rancher-cattle-metadata:
    network_mode: none
    labels:
      io.rancher.scheduler.affinity:container_label_soft_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
      io.rancher.container.hostname_override: container_name
      io.rancher.container.start_once: "true"
    image: webcenter/rancher-cattle-metadata:1.0.1
    volumes:
      - gocd-scheduler-setting:/opt/scheduler
  docker-engine:
    privileged: true
    labels:
      io.rancher.scheduler.affinity:container_label_soft_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
      io.rancher.container.hostname_override: container_name
    image: index.docker.io/docker:1.13-dind
    volumes:
    {{- if eq (printf "%.1s" .Values.VOLUME_DRIVER_AGENT) "/"}}
      - ${VOLUME_DRIVER_AGENT}:/data
    {{- else}}
      - gocd-agent-data:/data
    {{- end}}
  {{- end}}
  

volumes:
  gocd-scheduler-setting:
    driver: local
    per_container: true
  {{- if ne (printf "%.1s" .Values.VOLUME_DRIVER_AGENT) "/"}}
  gocd-agent-data:
    driver: ${VOLUME_DRIVER_AGENT}
    per_container: true
  {{- end}}
  {{- if ne (printf "%.1s" .Values.VOLUME_DRIVER_SERVER) "/"}}
  gocd-server-data:
    driver: ${VOLUME_DRIVER_SERVER}
  {{- end}}
