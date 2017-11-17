version: '2'
services:
{{- if eq .Values.rabbitmq_link ""}}
  rabbit:
    hostname: rabbit
    image: rabbitmq:3
{{- end}}

  receive:
    command: receive
{{- if ne .Values.rabbitmq_link ""}}
    external_links:
      - ${rabbitmq_link}:rabbit
    environment:
      - AMQ_HOST=rabbit.rancher.internal
{{- else}}
    links:
      - rabbit
    environment:
      - AMQ_HOST=rabbit
{{- end}}
    image: joshuacox/rabbitmq-tutorials
    labels:
      io.rancher.container.hostname_override: container_name
      io.rancher.sidekicks: send
{{- if ne .Values.host_label ""}}
      io.rancher.scheduler.affinity:host_label: ${host_label}
{{- end}}
  send:
    image: joshuacox/rabbitmq-tutorials
    labels:
      io.rancher.container.hostname_override: container_name
{{- if ne .Values.host_label ""}}
      io.rancher.scheduler.affinity:host_label: ${host_label}
{{- end}}
      io.rancher.container.start_once: true
    command: send
{{- if ne .Values.rabbitmq_link ""}}
    external_links:
      - ${rabbitmq_link}:rabbit
    environment:
      - AMQ_HOST=rabbit.rancher.internal
{{- else}}
    links:
      - rabbit
    environment:
      - AMQ_HOST=rabbit
{{- end}}

  worker:
    image: joshuacox/rabbitmq-tutorials
    labels:
      io.rancher.container.hostname_override: container_name
      io.rancher.sidekicks: newtask
{{- if ne .Values.host_label ""}}
      io.rancher.scheduler.affinity:host_label: ${host_label}
{{- end}}
    command: worker
{{- if ne .Values.rabbitmq_link ""}}
    external_links:
      - ${rabbitmq_link}:rabbit
    environment:
      - AMQ_HOST=rabbit.rancher.internal
{{- else}}
    links:
      - rabbit
    environment:
      - AMQ_HOST=rabbit
{{- end}}
  newtask:
    image: joshuacox/rabbitmq-tutorials
    labels:
      io.rancher.container.hostname_override: container_name
{{- if ne .Values.host_label ""}}
      io.rancher.scheduler.affinity:host_label: ${host_label}
{{- end}}
      io.rancher.container.start_once: true
    command: new_task
{{- if ne .Values.rabbitmq_link ""}}
    external_links:
      - ${rabbitmq_link}:rabbit
    environment:
      - AMQ_HOST=rabbit.rancher.internal
{{- else}}
    links:
      - rabbit
    environment:
      - AMQ_HOST=rabbit
{{- end}}

  rpcserver:
    image: joshuacox/rabbitmq-tutorials
    labels:
      io.rancher.container.hostname_override: container_name
      io.rancher.sidekicks: rpcclient
{{- if ne .Values.host_label ""}}
      io.rancher.scheduler.affinity:host_label: ${host_label}
{{- end}}
    command: rpc_server
{{- if ne .Values.rabbitmq_link ""}}
    external_links:
      - ${rabbitmq_link}:rabbit
    environment:
      - AMQ_HOST=rabbit.rancher.internal
{{- else}}
    links:
      - rabbit
    environment:
      - AMQ_HOST=rabbit
{{- end}}
  rpcclient:
    image: joshuacox/rabbitmq-tutorials
    labels:
      io.rancher.container.hostname_override: container_name
{{- if ne .Values.host_label ""}}
      io.rancher.scheduler.affinity:host_label: ${host_label}
{{- end}}
      io.rancher.container.start_once: true
    command: rpc_client 4
{{- if ne .Values.rabbitmq_link ""}}
    external_links:
      - ${rabbitmq_link}:rabbit
    environment:
      - AMQ_HOST=rabbit.rancher.internal
{{- else}}
    links:
      - rabbit
    environment:
      - AMQ_HOST=rabbit
{{- end}}

  receivelogs:
    image: joshuacox/rabbitmq-tutorials
    labels:
      io.rancher.container.hostname_override: container_name
      io.rancher.sidekicks: emitlog
{{- if ne .Values.host_label ""}}
      io.rancher.scheduler.affinity:host_label: ${host_label}
{{- end}}
    command: receive_logs
{{- if ne .Values.rabbitmq_link ""}}
    external_links:
      - ${rabbitmq_link}:rabbit
    environment:
      - AMQ_HOST=rabbit.rancher.internal
{{- else}}
    links:
      - rabbit
    environment:
      - AMQ_HOST=rabbit
{{- end}}
  emitlog:
    image: joshuacox/rabbitmq-tutorials
    labels:
      io.rancher.container.hostname_override: container_name
{{- if ne .Values.host_label ""}}
      io.rancher.scheduler.affinity:host_label: ${host_label}
{{- end}}
      io.rancher.container.start_once: true
    command: emit_log
{{- if ne .Values.rabbitmq_link ""}}
    external_links:
      - ${rabbitmq_link}:rabbit
    environment:
      - AMQ_HOST=rabbit.rancher.internal
{{- else}}
    links:
      - rabbit
    environment:
      - AMQ_HOST=rabbit
{{- end}}

  receivelogsdirect:
    image: joshuacox/rabbitmq-tutorials
    labels:
      io.rancher.container.hostname_override: container_name
      io.rancher.sidekicks: emitlogdirect
{{- if ne .Values.host_label ""}}
      io.rancher.scheduler.affinity:host_label: ${host_label}
{{- end}}
    command: receive_logs_direct info
{{- if ne .Values.rabbitmq_link ""}}
    external_links:
      - ${rabbitmq_link}:rabbit
    environment:
      - AMQ_HOST=rabbit.rancher.internal
{{- else}}
    links:
      - rabbit
    environment:
      - AMQ_HOST=rabbit
{{- end}}
  emitlogdirect:
    image: joshuacox/rabbitmq-tutorials
    labels:
      io.rancher.container.hostname_override: container_name
{{- if ne .Values.host_label ""}}
      io.rancher.scheduler.affinity:host_label: ${host_label}
{{- end}}
      io.rancher.container.start_once: true
    command: emit_log_direct
{{- if ne .Values.rabbitmq_link ""}}
    external_links:
      - ${rabbitmq_link}:rabbit
    environment:
      - AMQ_HOST=rabbit.rancher.internal
{{- else}}
    links:
      - rabbit
    environment:
      - AMQ_HOST=rabbit
{{- end}}

  receivelogstopic:
    image: joshuacox/rabbitmq-tutorials
    labels:
      io.rancher.container.hostname_override: container_name
      io.rancher.sidekicks: emitlogtopic
{{- if ne .Values.host_label ""}}
      io.rancher.scheduler.affinity:host_label: ${host_label}
{{- end}}
    command: receive_logs_topic anonymous.info
{{- if ne .Values.rabbitmq_link ""}}
    external_links:
      - ${rabbitmq_link}:rabbit
    environment:
      - AMQ_HOST=rabbit.rancher.internal
{{- else}}
    links:
      - rabbit
    environment:
      - AMQ_HOST=rabbit
{{- end}}
  emitlogtopic:
    image: joshuacox/rabbitmq-tutorials
    labels:
      io.rancher.container.hostname_override: container_name
{{- if ne .Values.host_label ""}}
      io.rancher.scheduler.affinity:host_label: ${host_label}
{{- end}}
      io.rancher.container.start_once: true
    command: emit_log_topic
{{- if ne .Values.rabbitmq_link ""}}
    external_links:
      - ${rabbitmq_link}:rabbit
    environment:
      - AMQ_HOST=rabbit.rancher.internal
{{- else}}
    links:
      - rabbit
    environment:
      - AMQ_HOST=rabbit
{{- end}}
