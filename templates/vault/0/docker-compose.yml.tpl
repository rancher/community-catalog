version: '2'
volumes:
  vault-config:
    driver: ${VOLUME_DRIVER}
  vault-file:
    driver: ${VOLUME_DRIVER}
services:
  vault-lb:
    image: rancher/lb-service-haproxy:v0.9.1
    ports:
    - ${VAULT_LISTEN_PORT}:8200/tcp
    - ${VAULT_CLUSTER_PORT}:8201/tcp
    labels:
      io.rancher.container.agent.role: environmentAdmin,agent
      io.rancher.container.agent_service.drain_provider: 'true'
      io.rancher.container.create_agent: 'true'
{{- if .Values.HOST_LABEL }}
      io.rancher.scheduler.affinity:host_label: ${HOST_LABEL}
{{- end }}
  vault:
    image: vault:0.9.6
    cap_add:
    - IPC_LOCK
{{- if .Values.BACKEND_SERVICE }}
    external_links:
    - ${BACKEND_SERVICE}:SERVICE
{{- end }}
    environment:
      VAULT_REDIRECT_INTERFACE: "eth0"
      VAULT_CLUSTER_INTERFACE: "eth0"
      VAULT_LOCAL_CONFIG: |
        {
          "storage":{"${VAULT_BACKEND}":{ ${BACKEND_CONFIGURATION} }},
          "listener":{"tcp":{"address":"0.0.0.0:8200","tls_disable":1}},
          "cluster_name":"${VAULT_CLUSTER_NAME}"
        }
    volumes:
    - vault-file:/vault/file
    - vault-config:/vault/config
    command:
    - server

