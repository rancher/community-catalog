version: '2'
{{- if not .Values.POSTGRES_SERVER }}
volumes:
  awx-pgdata1:
    driver: ${VOLUME_DRIVER}
{{- end }}
services:
{{- if not .Values.MEMCACHED_SERVER }}
  memcached:
    image: memcached:1.5.7-alpine
    stdin_open: true
    tty: true
{{- end }}
{{- if not .Values.POSTGRES_SERVER }}
  postgresql:
    image: postgres:9.6.8-alpine
    environment:
      POSTGRES_PASSWORD: ${DATABASE_PASSWORD}
      POSTGRES_USER: ${DATABASE_USERID}
      POSTGRES_DB: ${DATABASE_NAME}
      PGDATA: /var/lib/postgresql/data/pgdata
    stdin_open: true
    tty: true
    volumes_from:
    - postgresql-data
    labels:
      io.rancher.sidekicks: postgresql-data
  postgresql-data:
    image: busybox
    stdin_open: true
    volumes:
    - awx-pgdata1:/var/lib/postgresql/data/pgdata
    tty: true
    labels:
      io.rancher.container.start_once: 'true'
{{- end }}
  awx-web:
    image: ansible/awx_web:1.0.6.15
    hostname: awxweb
    environment:
      SECRET_KEY: ${SECRET_KEY}
      DATABASE_NAME: ${DATABASE_NAME}
      DATABASE_USER: ${DATABASE_USERID}
      DATABASE_PASSWORD: ${DATABASE_PASSWORD}
      DATABASE_PORT: ${DATABASE_PORT}
      DATABASE_HOST: postgres
      RABBITMQ_USER: ${RABBITMQ_USER}
      RABBITMQ_PASSWORD: ${RABBITMQ_PASSWORD}
      RABBITMQ_HOST: rabbitmq
      RABBITMQ_PORT: ${RABBITMQ_PORT}
      RABBITMQ_VHOST: ${RABBITMQ_VHOST}
      MEMCACHED_HOST: memcached
      MEMCACHED_PORT: ${MEMCACHED_PORT}
      AWX_ADMIN_USER: ${AWX_ADMIN_USER}
      AWX_ADMIN_PASSWORD: ${AWX_ADMIN_PASSWORD}
    stdin_open: true
    tty: true
{{- if or .Values.POSTGRES_SERVER .Values.RABBITMQ_SERVER .Values.MEMCACHED_SERVER }}
    external_links:
{{- end }}
{{- if .Values.POSTGRES_SERVER }}
    - ${POSTGRES_SERVER}:postgres
{{- end }}
{{- if .Values.RABBITMQ_SERVER }}
    - ${RABBITMQ_SERVER}:rabbitmq
{{- end }}
{{- if .Values.MEMCACHED_SERVER }}
    - ${MEMCACHED_SERVER}:memcached
{{- end }}
{{- if not (or .Values.POSTGRES_SERVER .Values.RABBITMQ_SERVER .Values.MEMCACHED_SERVER) }}
    links:
{{- end }}
{{- if not .Values.POSTGRES_SERVER }}
    - postgresql:postgres
{{- end }}
{{- if not .Values.RABBITMQ_SERVER }}
    - rabbitmq:rabbitmq
{{- end }}
{{- if not .Values.MEMCACHED_SERVER }}
    - memcached:memcached
{{- end }}
    user: root
  awx-lb:
    image: rancher/lb-service-haproxy:v0.9.1
    ports:
    - ${LB_LISTEN_PORT}:8052/tcp
    labels:
{{- if .Values.LB_HOST_LABEL }}
      io.rancher.scheduler.affinity:host_label: ${LB_HOST_LABEL}
{{- end }}
      io.rancher.container.agent.role: environmentAdmin,agent
      io.rancher.container.agent_service.drain_provider: 'true'
      io.rancher.container.create_agent: 'true'
{{- if not .Values.RABBITMQ_SERVER }}
  rabbitmq:
    image: rabbitmq:3.7.4-alpine
    environment:
      RABBITMQ_ERLANG_COOKIE: awx-erlang-cookie
      RABBITMQ_DEFAULT_VHOST: ${RABBITMQ_VHOST}
    stdin_open: true
    tty: true
{{- end }}
  awx-task:
    image: ansible/awx_task:1.0.6.15
    hostname: awx
    environment:
      SECRET_KEY: ${SECRET_KEY}
      DATABASE_NAME: ${DATABASE_NAME}
      DATABASE_USER: ${DATABASE_USERID}
      DATABASE_PASSWORD: ${DATABASE_PASSWORD}
      DATABASE_PORT: ${DATABASE_PORT}
      DATABASE_HOST: postgres
      RABBITMQ_USER: ${RABBITMQ_USER}
      RABBITMQ_PASSWORD: ${RABBITMQ_PASSWORD}
      RABBITMQ_HOST: rabbitmq
      RABBITMQ_PORT: ${RABBITMQ_PORT}
      RABBITMQ_VHOST: ${RABBITMQ_VHOST}
      MEMCACHED_HOST: memcached
      MEMCACHED_PORT: ${MEMCACHED_PORT}
      AWX_ADMIN_USER: ${AWX_ADMIN_USER}
      AWX_ADMIN_PASSWORD: ${AWX_ADMIN_PASSWORD}
    stdin_open: true
    tty: true
{{- if or .Values.POSTGRES_SERVER .Values.RABBITMQ_SERVER .Values.MEMCACHED_SERVER }}
    external_links:
{{- end }}
{{- if .Values.POSTGRES_SERVER }}
    - ${POSTGRES_SERVER}:postgres
{{- end }}
{{- if .Values.RABBITMQ_SERVER }}
    - ${RABBITMQ_SERVER}:rabbitmq
{{- end }}
{{- if .Values.MEMCACHED_SERVER }}
    - ${MEMCACHED_SERVER}:memcached
{{- end }}
{{- if not (or .Values.POSTGRES_SERVER .Values.RABBITMQ_SERVER .Values.MEMCACHED_SERVER) }}
    links:
{{- end }}
{{- if not .Values.POSTGRES_SERVER }}
    - postgresql:postgres
{{- end }}
{{- if not .Values.RABBITMQ_SERVER }}
    - rabbitmq:rabbitmq
{{- end }}
{{- if not .Values.MEMCACHED_SERVER }}
    - memcached:memcached
{{- end }}
    - awx-web:web
    user: root
