version: '2'
services:
  sonarqube-lb:
    image: rancher/lb-service-haproxy:v0.7.6
    ports:
      - ${http_port}:${http_port}
  sonarqube-storage:
    network_mode: none
    labels:
      io.rancher.container.hostname_override: container_name
      io.rancher.container.start_once: true
    environment:
      - SERVICE_UID=0
      - SERVICE_GID=0
      - SERVICE_VOLUME=/opt/sonarqube/extensions/plugins
    volumes:
      - sonarqube-plugin:/opt/sonarqube/extensions/plugins
    image: rawmind/alpine-volume:0.0.2-1
  sonarqube:
    labels:
      io.rancher.container.hostname_override: container_name
      io.rancher.sidekicks: sonarqube-storage
    image: sonarqube:${docker_version}
    environment:
      SONARQUBE_WEB_JVM_OPTS: ${jvm_opts}
      SONARQUBE_JDBC_USERNAME: ${postgres_user}
      SONARQUBE_JDBC_PASSWORD: ${postgres_password}
      SONARQUBE_JDBC_URL: jdbc:postgresql://db:${postgres_port}/${postgres_db}
    volumes_from:
      - sonarqube-storage
{{- if ne .Values.postgres_link ""}}
    external_links:
      - ${postgres_link}:db
{{- else}}
    links:
      - db:db
  db:
    labels:
      io.rancher.container.hostname_override: container_name
      io.rancher.sidekicks: db-storage
    image: postgres:9.6.3-alpine
    environment:
      POSTGRES_USER:  ${postgres_user}
      POSTGRES_PASSWORD:  ${postgres_password}
      POSTGRES_DB:  ${postgres_db}
    volumes_from:
      - db-storage
  db-storage:
    network_mode: none
    labels:
      io.rancher.container.hostname_override: container_name
      io.rancher.container.start_once: true
    environment:
      - SERVICE_UID=0
      - SERVICE_GID=0
      - SERVICE_VOLUME=/var/lib/postgresql
    volumes:
      - db-data:/var/lib/postgresql
    image: rawmind/alpine-volume:0.0.2-1
{{- end}}
volumes:
  sonarqube-plugin:
    driver: local
{{- if eq .Values.postgres_link ""}}
  db-data:
    driver: local
{{- end}}
