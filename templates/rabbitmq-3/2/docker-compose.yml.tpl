version: '2'
services:
  rabbitmq:
    image: webhostingcoopteam/rabbitmq-conf:0.2.1
    labels:
      io.rancher.container.hostname_override: container_name
      io.rancher.scheduler.affinity:container_label_soft_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
      io.rancher.sidekicks: rabbitmq-base,rabbitmq-datavolume
    {{- if ne .Values.host_label ""}}
      io.rancher.scheduler.affinity:host_label: ${host_label}
    {{- end}}
    volumes_from:
      - rabbitmq-datavolume
    environment:
      - RABBITMQ_NET_TICKTIME=${net_ticktime}
      - RABBITMQ_CLUSTER_PARTITION_HANDLING=${cluster_partition_handling}
      - CONFD_ARGS=${confd_args}
  rabbitmq-datavolume:
    network_mode: "none"
    labels:
      io.rancher.container.hostname_override: container_name
      io.rancher.scheduler.affinity:container_label_soft_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
    {{- if ne .Values.host_label ""}}
      io.rancher.scheduler.affinity:host_label: ${host_label}
    {{- end}}
      io.rancher.container.start_once: true
    volumes:
      - rabbitconf:/etc/rabbitmq
      - rancherbin:/opt/rancher/bin
    entrypoint: /bin/true
    image: rabbitmq:3.6-management-alpine
  rabbitmq-base:
    network_mode: "container:rabbitmq"
    labels:
      io.rancher.container.hostname_override: container_name
      io.rancher.scheduler.affinity:container_label_soft_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
    {{- if ne .Values.host_label ""}}
      io.rancher.scheduler.affinity:host_label: ${host_label}
    {{- end}}
    image: rabbitmq:3.6-management-alpine
    restart: always
    volumes_from:
      - rabbitmq-datavolume
    entrypoint:
      - /opt/rancher/bin/run.sh
    environment:
      - RABBITMQ_ERLANG_COOKIE=${erlang_cookie}
volumes:
  rancherbin:
    driver: ${VOLUME_DRIVER}
    per_container: true
  rabbitconf:
    driver: ${VOLUME_DRIVER}
    per_container: true
