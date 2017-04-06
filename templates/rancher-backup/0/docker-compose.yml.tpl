version: '2'
services:
  backup:
    environment:
      - BACKUP_cron_schedule=${CRON_SCHEDULE}
      - BACKUP_duplicity_url=${BACKEND}
      - BACKUP_duplicity_target-path=${TARGET_PATH}
      - BACKUP_duplicity_source-path=/backup
      - BACKUP_duplicity_full-if-older-than=${BK_FULL_FREQ}
      - BACKUP_duplicity_remove-all-but-n-full=${BK_KEEP_FULL}
      - BACKUP_duplicity_remove-all-inc-of-but-n-full=${BK_KEEP_FULL_CHAIN}
      - BACKUP_duplicity_volsize=${VOLUME_SIZE}
      - BACKUP_duplicity_options=${DUPLICITY_OPTIONS}
      - DEBUG=false
      - BACKUP_module_database=${ENABLE_DUMP_SERVICE}
      - BACKUP_module_stack=${ENABLE_DUMP_STACK}
      - BACKUP_module_rancher-db=${ENABLE_DUMP_RANCHER_DATABASE}
      - BACKUP_rancher_db_host=${RANCHER_DATABASE_HOST}
      - BACKUP_rancher_db_port=${RANCHER_DATABASE_PORT}
      - BACKUP_rancher_db_user=${RANCHER_DATABASE_USER}
      - BACKUP_rancher_db_password=${RANCHER_DATABASE_PASSWORD}
      - BACKUP_rancher_db_name=${RANCHER_DATABASE_NAME}
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
    labels:
      io.rancher.sidekicks: docker-engine
      io.rancher.container.create_agent: true
      io.rancher.container.agent.role: environment
    tty: true
    image: webcenter/rancher-backup:2.0.0
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
  {{- end}}

{{- if not (contains .Values.VOLUME_DRIVER "/")}}
volumes:
  backup-data:
    driver: local
{{- end}}
