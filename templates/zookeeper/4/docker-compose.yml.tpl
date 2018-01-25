version: '2'
services:
  zk:
    tty: true
    image: rawmind/alpine-zk:3.4.10-0
    volumes_from:
      - zk-volume
      - zk-conf
    environment:
      - JVMFLAGS=-Xmx${zk_mem}m -Xms${zk_mem}m
      - CONFD_INTERVAL=${zk_interval}
      - ZK_DATA_DIR=${zk_data_dir}
      - ZK_INIT_LIMIT=${zk_init_limit}
      - ZK_MAX_CLIENT_CXNS=${zk_max_client_cxns}
      - ZK_SYNC_LIMIT=${zk_sync_limit}
      - ZK_TICK_TIME=${zk_tick_time}
    labels:
      io.rancher.scheduler.affinity:container_label_soft_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
      io.rancher.container.hostname_override: container_name
{{- if ne .Values.host_label ""}}
      io.rancher.scheduler.affinity:host_label: ${host_label}
{{- end}}
      io.rancher.sidekicks: zk-volume, zk-conf
  zk-conf:
    network_mode: none
    labels:
      io.rancher.scheduler.affinity:container_label_soft_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
      io.rancher.container.hostname_override: container_name
{{- if ne .Values.host_label ""}}
      io.rancher.scheduler.affinity:host_label: ${host_label}
{{- end}}
      io.rancher.container.start_once: true
    image: rawmind/rancher-zk:3.4.9
    volumes:
      - zkconfig:/opt/tools
  zk-volume:
    network_mode: none
    labels:
      io.rancher.scheduler.affinity:container_label_soft_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
      io.rancher.container.hostname_override: container_name
{{- if ne .Values.host_label ""}}
      io.rancher.scheduler.affinity:host_label: ${host_label}
{{- end}}
      io.rancher.container.start_once: true
    environment:
      - SERVICE_UID=10002
      - SERVICE_GID=10002
      - SERVICE_VOLUME=${zk_data_dir}
    volumes:
      - zkdata:${zk_data_dir}
    image: rawmind/alpine-volume:0.0.2-1
volumes:
  zkconfig:
    driver: ${VOLUME_DRIVER}
    per_container: true
  zkdata:
    driver: ${VOLUME_DRIVER}
    per_container: true
