version: '2'
volumes:
  vault-config:
    driver: ${volumeDriver}
  vault-file:
    driver: ${volumeDriver}
services:
  vault-lb:
    image: rancher/lb-service-haproxy:v0.7.15
    ports:
    - 8200:8200/tcp
    - 8201:8201/tcp
    labels:
      io.rancher.scheduler.affinity:host_label: lbhost=true
      io.rancher.container.agent.role: environmentAdmin,agent
      io.rancher.container.agent_service.drain_provider: 'true'
      io.rancher.container.create_agent: 'true'
  vault:
    cap_add:
    - IPC_LOCK
    image: vault
    environment:
      VAULT_LOCAL_CONFIG: ${VAULT_LOCAL_CONFIG}
{{- if eq .Values.useConsul "true"}}
    external_links:
    - ${consulService}:consul
{{- end}}
    volumes:
    - vault-file:/vault/file
    - vault-config:/vault/config
    logging:
      driver: journald
    command:
    - server
    labels:
      io.rancher.container.pull_image: always
