version: '2'
services:
  letsencrypt:
    image: janeczku/rancher-letsencrypt:v0.5.0
    environment:
      EULA: ${EULA}
      API_VERSION: ${API_VERSION}
      CERT_NAME: ${CERT_NAME}
      EMAIL: ${EMAIL}
      DOMAINS: ${DOMAINS}
      DNS_RESOLVERS: ${DNS_RESOLVERS}
      PUBLIC_KEY_TYPE: ${PUBLIC_KEY_TYPE}
      RENEWAL_TIME: ${RENEWAL_TIME}
      RENEWAL_PERIOD_DAYS: ${RENEWAL_PERIOD_DAYS}
      PROVIDER: ${PROVIDER}
      CLOUDFLARE_EMAIL: ${CLOUDFLARE_EMAIL}
      CLOUDFLARE_KEY: ${CLOUDFLARE_KEY}
      DO_ACCESS_TOKEN: ${DO_ACCESS_TOKEN}
      AWS_ACCESS_KEY: ${AWS_ACCESS_KEY}
      AWS_SECRET_KEY: ${AWS_SECRET_KEY}
      DNSIMPLE_EMAIL: ${DNSIMPLE_EMAIL}
      DNSIMPLE_KEY: ${DNSIMPLE_KEY}
      DYN_CUSTOMER_NAME: ${DYN_CUSTOMER_NAME}
      DYN_USER_NAME: ${DYN_USER_NAME}
      DYN_PASSWORD: ${DYN_PASSWORD}
      VULTR_API_KEY: ${VULTR_API_KEY}
      OVH_APPLICATION_KEY: ${OVH_APPLICATION_KEY}
      OVH_APPLICATION_SECRET: ${OVH_APPLICATION_SECRET}
      OVH_CONSUMER_KEY: ${OVH_CONSUMER_KEY}
      GANDI_API_KEY: ${GANDI_API_KEY}
      AZURE_CLIENT_ID: ${AZURE_CLIENT_ID}
      AZURE_CLIENT_SECRET: ${AZURE_CLIENT_SECRET}
      AZURE_SUBSCRIPTION_ID: ${AZURE_SUBSCRIPTION_ID}
      AZURE_TENANT_ID: ${AZURE_TENANT_ID}
      AZURE_RESOURCE_GROUP: ${AZURE_RESOURCE_GROUP}
    volumes:
      - /var/lib/rancher:/var/lib/rancher
      {{- if .Values.VOLUME_NAME}}
      - {{.Values.VOLUME_NAME}}:/etc/letsencrypt
      {{- end }}
    labels:
      io.rancher.container.create_agent: 'true'
      io.rancher.container.agent.role: 'environment'
      {{- if eq .Values.RUN_ONCE "true" }}
      io.rancher.container.start_once: "true"
      {{- end }}
{{- if .Values.VOLUME_NAME}}
volumes:
  {{.Values.VOLUME_NAME}}:
    {{- if .Values.STORAGE_DRIVER}}
    driver: {{.Values.STORAGE_DRIVER}}
    {{- if .Values.STORAGE_DRIVER_OPT}}
    driver_opts:
      {{.Values.STORAGE_DRIVER_OPT}}
    {{- end }}
    {{- end }}
{{- end }}
