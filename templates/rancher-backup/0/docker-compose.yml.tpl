version: '2'
services:
  backup:
    environment:
      - BACKUP_CRON_schedule=${CRON_SCHEDULE}
      - BACKUP_DUPLICITY_url=${BACKEND}
      - BACKUP_DUPLICITY_target-path=${TARGET_PATH}
      - BACKUP_DUPLICITY_source-path=/backup
      - BACKUP_DUPLICITY_full-if-older-than=${BK_FULL_FREQ}
      - BACKUP_DUPLICITY_remove-all-but-n-full=${BK_KEEP_FULL}
      - BACKUP_DUPLICITY_remove-all-inc-of-but-n-full=${BK_KEEP_FULL_CHAIN}
      - BACKUP_DUPLICITY_volsize=${VOLUME_SIZE}
      - BACKUP_DUPLICITY_options=${DUPLICITY_OPTIONS}
      - DEBUG=false
      - BACKUP_MODULE_database=${ENABLE_DUMP_SERVICE}
      - BACKUP_MODULE_stack=${ENABLE_DUMP_STACK}
      - BACKUP_MODULE_rancher-db=${ENABLE_DUMP_RANCHER_DATABASE}
      - BACKUP_RANCHER_db_host=${RANCHER_DATABASE_HOST}
      - BACKUP_RANCHER_db_port=${RANCHER_DATABASE_PORT}
      - BACKUP_RANCHER_db_user=${RANCHER_DATABASE_USER}
      - BACKUP_RANCHER_db_password=${RANCHER_DATABASE_PASSWORD}
      - BACKUP_RANCHER_db_name=${RANCHER_DATABASE_NAME}
      - DOCKER_HOST=docker-engine:2375
      - FTP_PASSWORD=${FTP_PASSWORD}
      - AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
      - AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
      - AZURE_ACCOUNT_NAME=${AZURE_ACCOUNT_NAME}
      - AZURE_ACCOUNT_KEY=${AZURE_ACCOUNT_KEY}
      - CLOUDFILES_USERNAME=${CLOUDFILES_USERNAME}
      - CLOUDFILES_APIKEY=${CLOUDFILES_APIKEY}
      - DPBX_ACCESS_TOKEN=${DPBX_ACCESS_TOKEN}
      - GS_ACCESS_KEY_ID=${GS_ACCESS_KEY_ID}
      - GS_SECRET_ACCESS_KEY=${GS_SECRET_ACCESS_KEY}
      - GOOGLE_DRIVE_ACCOUNT_KEY=${GOOGLE_DRIVE_ACCOUNT_KEY}
      - SWIFT_USERNAME=${SWIFT_USERNAME}
      - SWIFT_PASSWORD=${SWIFT_PASSWORD}
      - SWIFT_AUTHURL=${SWIFT_AUTHURL}
      - CONFD_BACKEND=${CONFD_BACKEND}
      - CONFD_NODES=${CONFD_NODES}
      - CONFD_PREFIX_KEY=${CONFD_PREFIX}
    labels:
      io.rancher.sidekicks: docker-engine
      io.rancher.container.create_agent: true
      io.rancher.container.agent.role: environment
    tty: true
    image: webcenter/rancher-backup:2.0.0-2
    stdin_open: false
    volumes:
    {{- if (contains .Values.VOLUME_DRIVER "/")}}
      - ${VOLUME_DRIVER}:/data
    {{- else}}
      - backup-data:/data
    {{- end}}
  docker-engine:
    privileged: true
    labels:
      io.rancher.scheduler.affinity:container_label_soft_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
      io.rancher.container.hostname_override: container_name
    image: index.docker.io/docker:1.13-dind
    volumes:
    {{- if (contains .Values.VOLUME_DRIVER "/")}}
      - ${VOLUME_DRIVER}:/data
    {{- else}}
      - backup-data:/backup
    {{- end}}

{{- if not (contains .Values.VOLUME_DRIVER "/")}}
volumes:
  backup-data:
    driver: local
{{- end}}
