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
      io.rancher.scheduler.affinity:host_label: lbhost=true
      io.rancher.container.agent.role: environmentAdmin,agent
      io.rancher.container.agent_service.drain_provider: 'true'
      io.rancher.container.create_agent: 'true'
  vault:
    cap_add:
    - IPC_LOCK
    image: vault:0.9.6
    environment:
      VAULT_LOCAL_CONFIG: ${VAULT_LOCAL_CONFIG}
      VAULT_REDIRECT_INTERFACE: "eth0"
      VAULT_CLUSTER_INTERFACE: "eth0"
{{- if eq .Values.USE_CONSUL "true"}}
    external_links:
    - ${CONSUL_SERVICE}:consul
{{- end}}
    volumes:
    - vault-file:/vault/file
    - vault-config:/vault/config
    command:
    - server

