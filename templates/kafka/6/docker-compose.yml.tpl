version: '2'
services:
  broker:
    tty: true
    image: rawmind/alpine-kafka:1.1.0-0
    volumes_from:
      - broker-volume
      - broker-conf
    environment:
      - JVMFLAGS=-Xmx${kafka_mem}m -Xms${kafka_mem}m
      - CONFD_INTERVAL=${kafka_interval}
      - ZK_SERVICE=${zk_link}
      - KAFKA_DELETE_TOPICS=${kafka_delete_topics}
      - KAFKA_LOG_DIRS=${kafka_log_dir}
      - KAFKA_LOG_RETENTION_HOURS=${kafka_log_retention}
      - KAFKA_NUM_PARTITIONS=${kafka_num_partitions}
      - ADVERTISE_PUB_IP=${kafka_pub_ip}
      - KAFKA_ADVERTISE_PORT=${kafka_adv_port}
      - KAFKA_AUTO_CREATE_TOPICS=${kafka_auto_create_topics}
      - KAFKA_REPLICATION_FACTOR=${kafka_replication_factor}
      - KAFKA_OFFSET_RETENTION_MINUTES=${kafka_offset_retention_minutes}
    external_links:
      - ${zk_link}:zk
  {{- if eq .Values.kafka_pub_ip "true"}}
    ports:
      - ${kafka_adv_port}:${kafka_adv_port}/tcp
  {{- end}}
    labels: 
      io.rancher.scheduler.affinity:container_label_soft_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
      io.rancher.container.hostname_override: container_name
      io.rancher.sidekicks: broker-volume, broker-conf
    {{- if ne .Values.host_label ""}}
      io.rancher.scheduler.affinity:host_label: ${host_label}
    {{- end}}
  broker-conf:
    network_mode: none
    labels:
      io.rancher.scheduler.affinity:container_label_soft_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
      io.rancher.container.hostname_override: container_name
      io.rancher.container.start_once: true
    {{- if ne .Values.host_label ""}}
      io.rancher.scheduler.affinity:host_label: ${host_label}
    {{- end}}
    image: rawmind/rancher-kafka:0.11.0.0-2
    volumes:
      - brokerconfig:/opt/tools
  broker-volume:
    network_mode: none
    labels:
      io.rancher.scheduler.affinity:container_label_soft_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
      io.rancher.container.hostname_override: container_name
      io.rancher.container.start_once: true
    {{- if ne .Values.host_label ""}}
      io.rancher.scheduler.affinity:host_label: ${host_label}
    {{- end}}
    environment:
      - SERVICE_UID=10003
      - SERVICE_GID=10003
      - SERVICE_VOLUME=${kafka_log_dir}
    volumes:
      - brokerdata:${kafka_log_dir}
    image: rawmind/alpine-volume:0.0.2-1
volumes:
  brokerconfig:
    driver: local
    per_container: true
  brokerdata:
    driver: local
    per_container: true
