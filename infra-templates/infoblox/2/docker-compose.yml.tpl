version: '2'
services:
  infoblox:
    image: rancher/external-dns:v0.7.10
    command: -provider=infoblox {{if eq .Values.DEBUG_MODE "true" -}}-debug{{- end}}
    expose:
     - 1000
    labels:
      io.rancher.container.create_agent: "true"
      io.rancher.container.agent.role: "external-dns"
    environment:
      INFOBLOX_URL: ${INFOBLOX_URL}
      INFOBLOX_USER_NAME: ${INFOBLOX_USER_NAME}
      ROOT_DOMAIN: ${ROOT_DOMAIN}
      SSL_VERIFY: ${SSL_VERIFY}
      USE_COOKIES: ${USE_COOKIES}
      TTL: ${TTL}
{{- if eq .Values.INFOBLOX_PASSWORD_TYPE "env"}}
      INFOBLOX_PASSWORD: ${INFOBLOX_PASSWORD}
{{- else}}
      INFOBLOX_PASSWORD: ''
      INFOBLOX_SECRET: '/run/secrets/${INFOBLOX_PASSWORD}'
    secrets:
      - mode: '0444'
        uid: '0'
        gid: '0'
        source: '${INFOBLOX_PASSWORD}'
        target: ''
secrets:
  {{- .Values.INFOBLOX_PASSWORD}}:
    external: 'true' 
{{- end}}
