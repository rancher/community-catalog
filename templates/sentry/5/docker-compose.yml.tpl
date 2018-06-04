version: "2"
services:
  sentry-postgres:
    environment:
      POSTGRES_DB: ${sentry_db_name}
      POSTGRES_USER: ${sentry_db_user}
      POSTGRES_PASSWORD: ${sentry_db_pass}
      PGDATA: /data/postgres/data
    labels:
      io.rancher.container.hostname_override: container_name
    volumes:
      - sentry-postgres:/data/postgres/data
    image: postgres:9.6-alpine
  sentry-cron:
    environment:
      SENTRY_EMAIL_HOST: ${sentry_email_host}
      SENTRY_EMAIL_PASSWORD: ${sentry_email_password}
      SENTRY_EMAIL_PORT: ${sentry_email_port}
      SENTRY_EMAIL_USER: ${sentry_email_user}
      SENTRY_SECRET_KEY: ${sentry_secret_key}
      SENTRY_SERVER_EMAIL: ${sentry_server_email}
      SENTRY_POSTGRES_HOST: ${sentry_db_host}
      SENTRY_DB_NAME: ${sentry_db_name}
      SENTRY_DB_USER: ${sentry_db_user}
      SENTRY_DB_PASSWORD: ${sentry_db_pass}
    labels:
      io.rancher.container.hostname_override: container_name
    command:
    - run
    - cron
    image: sentry:8.21.0
    links:
    - sentry-postgres:postgres
    - sentry-redis:redis
  sentry-redis:
    labels:
      io.rancher.container.hostname_override: container_name
    image: redis:3.2-alpine
  sentry:
    {{- if .Values.sentry_public_port}}
    ports:
    - ${sentry_public_port}:9000/tcp
    {{- end}}
    environment:
      SENTRY_EMAIL_HOST: ${sentry_email_host}
      SENTRY_EMAIL_PASSWORD: ${sentry_email_password}
      SENTRY_EMAIL_PORT: ${sentry_email_port}
      SENTRY_EMAIL_USER: ${sentry_email_user}
      SENTRY_SECRET_KEY: ${sentry_secret_key}
      SENTRY_SERVER_EMAIL: ${sentry_server_email}
      SENTRY_POSTGRES_HOST: ${sentry_db_host}
      SENTRY_DB_NAME: ${sentry_db_name}
      SENTRY_DB_USER: ${sentry_db_user}
      SENTRY_DB_PASSWORD: ${sentry_db_pass}
    labels:
      io.rancher.container.hostname_override: container_name
    command:
    - /bin/bash
    - -c
    - sentry upgrade --noinput && sentry createuser --email ${sentry_initial_user_email} --password ${sentry_initial_user_password} --superuser && /entrypoint.sh run web || /entrypoint.sh run web
    image: sentry:8.21.0
    links:
    - sentry-postgres:postgres
    - sentry-redis:redis
  sentry-worker:
    environment:
      SENTRY_EMAIL_HOST: ${sentry_email_host}
      SENTRY_EMAIL_PASSWORD: ${sentry_email_password}
      SENTRY_EMAIL_PORT: ${sentry_email_port}
      SENTRY_EMAIL_USER: ${sentry_email_user}
      SENTRY_SECRET_KEY: ${sentry_secret_key}
      SENTRY_SERVER_EMAIL: ${sentry_server_email}
      SENTRY_POSTGRES_HOST: ${sentry_db_host}
      SENTRY_DB_NAME: ${sentry_db_name}
      SENTRY_DB_USER: ${sentry_db_user}
      SENTRY_DB_PASSWORD: ${sentry_db_pass}
    labels:
      io.rancher.scheduler.global: 'true'
      io.rancher.container.hostname_override: container_name
    command:
    - run
    - worker
    image: sentry:8.21.0
    links:
    - sentry-postgres:postgres
    - sentry-redis:redis

volumes:
  sentry-postgres:
    driver: ${sentry_storage_driver}
    driver_opts:
      {{.Values.sentry_storage_driver_opt}}
