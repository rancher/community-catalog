version: '2'
services:
{{- if eq .Values.rabbitmq_link ""}}
  rabbit:
    hostname: rabbit
    image: rabbitmq:3
  send:
    image: joshuacox/rabbitmq-tutorials
    labels:
      io.rancher.container.hostname_override: container_name
      io.rancher.scheduler.affinity:host_label: ${host_label}
      io.rancher.container.start_once: true
    environment:
      - AMQ_HOST=rabbit
    command: send
{{- end}}
  receive:
    command: receive
{{- if ne .Values.rabbitmq_link ""}}
    external_links:
      - ${rabbitmq_link}:rabbit
{{- end}}
    image: joshuacox/rabbitmq-tutorials
    labels:
      io.rancher.container.hostname_override: container_name
      io.rancher.scheduler.affinity:host_label: ${host_label}
    environment:
      - AMQ_HOST=rabbit
  send:
    image: joshuacox/rabbitmq-tutorials
    labels:
      io.rancher.container.hostname_override: container_name
      io.rancher.scheduler.affinity:host_label: ${host_label}
      io.rancher.container.start_once: true
    environment:
      - AMQ_HOST=rabbit
    command: send
{{- if ne .Values.rabbitmq_link ""}}
    external_links:
      - ${rabbitmq_link}:rabbit
{{- end}}

  worker:
    image: joshuacox/rabbitmq-tutorials
    labels:
      io.rancher.container.hostname_override: container_name
      io.rancher.scheduler.affinity:host_label: ${host_label}
    environment:
      - AMQ_HOST=rabbit
    command: worker
{{- if ne .Values.rabbitmq_link ""}}
    external_links:
      - ${rabbitmq_link}:rabbit
{{- end}}
  newtask:
    image: joshuacox/rabbitmq-tutorials
    labels:
      io.rancher.container.hostname_override: container_name
      io.rancher.scheduler.affinity:host_label: ${host_label}
      io.rancher.container.start_once: true
    environment:
      - AMQ_HOST=rabbit
    command: new_task
{{- if ne .Values.rabbitmq_link ""}}
    external_links:
      - ${rabbitmq_link}:rabbit
{{- end}}

  rpcserver:
    image: joshuacox/rabbitmq-tutorials
    labels:
      io.rancher.container.hostname_override: container_name
      io.rancher.scheduler.affinity:host_label: ${host_label}
    environment:
      - AMQ_HOST=rabbit
    command: rpc_server
{{- if ne .Values.rabbitmq_link ""}}
    external_links:
      - ${rabbitmq_link}:rabbit
{{- end}}
  rpcclient:
    image: joshuacox/rabbitmq-tutorials
    labels:
      io.rancher.container.hostname_override: container_name
      io.rancher.scheduler.affinity:host_label: ${host_label}
      io.rancher.container.start_once: true
    environment:
      - AMQ_HOST=rabbit
    command: rpc_client 4
{{- if ne .Values.rabbitmq_link ""}}
    external_links:
      - ${rabbitmq_link}:rabbit
{{- end}}

  receivelogs:
    image: joshuacox/rabbitmq-tutorials
    labels:
      io.rancher.container.hostname_override: container_name
      io.rancher.scheduler.affinity:host_label: ${host_label}
    environment:
      - AMQ_HOST=rabbit
    command: receive_logs
{{- if ne .Values.rabbitmq_link ""}}
    external_links:
      - ${rabbitmq_link}:rabbit
{{- end}}
  emitlog:
    image: joshuacox/rabbitmq-tutorials
    labels:
      io.rancher.container.hostname_override: container_name
      io.rancher.scheduler.affinity:host_label: ${host_label}
      io.rancher.container.start_once: true
    environment:
      - AMQ_HOST=rabbit
    command: emit_log
{{- if ne .Values.rabbitmq_link ""}}
    external_links:
      - ${rabbitmq_link}:rabbit
{{- end}}

  receivelogsdirect:
    image: joshuacox/rabbitmq-tutorials
    labels:
      io.rancher.container.hostname_override: container_name
      io.rancher.scheduler.affinity:host_label: ${host_label}
    environment:
      - AMQ_HOST=rabbit
    command: receive_logs_direct info
{{- if ne .Values.rabbitmq_link ""}}
    external_links:
      - ${rabbitmq_link}:rabbit
{{- end}}
  emitlogdirect:
    image: joshuacox/rabbitmq-tutorials
    labels:
      io.rancher.container.hostname_override: container_name
      io.rancher.scheduler.affinity:host_label: ${host_label}
      io.rancher.container.start_once: true
    environment:
      - AMQ_HOST=rabbit
    command: emit_log_direct
{{- if ne .Values.rabbitmq_link ""}}
    external_links:
      - ${rabbitmq_link}:rabbit
{{- end}}

  receivelogstopic:
    image: joshuacox/rabbitmq-tutorials
    labels:
      io.rancher.container.hostname_override: container_name
      io.rancher.scheduler.affinity:host_label: ${host_label}
    environment:
      - AMQ_HOST=rabbit
    command: receive_logs_topic anonymous.info
{{- if ne .Values.rabbitmq_link ""}}
    external_links:
      - ${rabbitmq_link}:rabbit
{{- end}}
  emitlogtopic:
    image: joshuacox/rabbitmq-tutorials
    labels:
      io.rancher.container.hostname_override: container_name
      io.rancher.scheduler.affinity:host_label: ${host_label}
      io.rancher.container.start_once: true
    environment:
      - AMQ_HOST=rabbit
    command: emit_log_topic
{{- if ne .Values.rabbitmq_link ""}}
    external_links:
      - ${rabbitmq_link}:rabbit
{{- end}}
