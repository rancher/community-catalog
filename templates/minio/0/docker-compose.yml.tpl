version: '2'
services:
  minio-server:
    tty: true
    image: webcenter/alpine-minio:2017-03-16_4
    volumes:
      - minio-scheduler-setting:/opt/scheduler
    {{- if eq (printf "%.1s" .Values.VOLUME_DRIVER) "/" }}
      {{- range $idx, $e := atoi .Values.MINIO_DISKS | until }}
      - ${VOLUME_DRIVER}/${DISK_BASE_NAME}{{$idx}}:/data/disk{{$idx}}
      {{- end}}
    {{- else}}
       {{- range $idx, $e := atoi .Values.MINIO_DISKS | until }}
      - minio-data-{{$idx}}:/data/disk{{$idx}}
      {{- end}}
    {{- end}}
    environment:
      - MINIO_CONFIG_minio.access.key=${MINIO_ACCESS_KEY}
      - MINIO_CONFIG_minio.secret.key=${MINIO_SECRET_KEY}
      - CONFD_BACKEND=${CONFD_BACKEND}
      - CONFD_NODES=${CONFD_NODES}
      - CONFD_PREFIX_KEY=${CONFD_PREFIX}
      {{- range $idx, $e := atoi .Values.MINIO_DISKS | until }}
      - MINIO_DISKS_{{$idx}}=disk{{$idx}}
      {{- end}}
    {{- if (ne .Values.DEPLOY_LB "true") and .Values.PUBLISH_PORT}}
    ports:
      - ${PUBLISH_PORT}:9000
    {{- end}}
    labels:
      io.rancher.scheduler.affinity:container_label_soft_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
      io.rancher.container.hostname_override: container_name
      io.rancher.sidekicks: rancher-cattle-metadata
  rancher-cattle-metadata:
    network_mode: none
    labels:
      io.rancher.scheduler.affinity:container_label_soft_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
      io.rancher.container.hostname_override: container_name
      io.rancher.container.start_once: "true"
    image: webcenter/rancher-cattle-metadata:1.0.1
    volumes:
      - minio-scheduler-setting:/opt/scheduler
  {{- if eq .Values.DEPLOY_LB "true"}}
  lb:
    image: rancher/lb-service-haproxy:v0.6.2
    {{- if .Values.PUBLISH_PORT}}
    ports:
      - ${PUBLISH_PORT}:9000/tcp
    {{- else}}
    expose:
      - 9000:9000/tcp
    {{- end}}
    links:
      - minio-server:minio-server
    labels:
      io.rancher.container.agent.role: environmentAdmin
      io.rancher.container.create_agent: 'true'
  {{- end}}

volumes:
  minio-scheduler-setting:
    driver: local
    per_container: true
  {{- if ne (printf "%.1s" .Values.VOLUME_DRIVER) "/" }}
    {{- range $idx, $e := atoi .Values.MINIO_DISKS | until }}
  minio-data-{{$idx}}:
    per_container: true
    driver: ${VOLUME_DRIVER}
    {{- end}}
  {{- end}}