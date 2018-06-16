version: '2'

services:
  openhab:
{{- if eq .Values.PCAP_SUPPORT_ENABLED "true"}}
    cap_add:
      - NET_ADMIN
      - NET_RAW
    command: "./start.sh"
{{- end}}
{{- if or (ne .Values.DEVICE_MAPPING_1 "") (ne .Values.DEVICE_MAPPING_2 "") }}
    devices:
{{- end}}
{{- if ne .Values.DEVICE_MAPPING_1 ""}}
     - "${DEVICE_MAPPING_1}"
{{- end}}
{{- if ne .Values.DEVICE_MAPPING_2 ""}}
     - "${DEVICE_MAPPING_2}"
{{- end}}
    environment:
      CRYPTO_POLICY: "${CRYPTO_POLICY}"
{{- if ne .Values.EXTRA_JAVA_OPTS ""}}
      EXTRA_JAVA_OPTS: "${EXTRA_JAVA_OPTS}"
{{- end}}
      OPENHAB_HTTP_PORT: "${HTTP_PORT}"
      OPENHAB_HTTPS_PORT: "${HTTPS_PORT}"
    image: "openhab/openhab:2.3.0-${IMAGE_ARCHITECTURE}-${IMAGE_DISTRIBUTION}"
    labels:
      io.rancher.container.pull_image: always
{{- if ne .Values.HOST_LABEL ""}}
      io.rancher.scheduler.affinity:host_label: ${HOST_LABEL}
{{- end}}
{{- if ne .Values.NETWORK_MODE "managed"}}
    network_mode: ${NETWORK_MODE}
{{- end}}
    ports:
      - ${HTTP_PORT}:${HTTP_PORT}
      - ${HTTPS_PORT}:${HTTPS_PORT}
    restart: unless-stopped
    tty: true
    volumes:
{{- if eq .Values.USE_HOST_TIME "true"}}
      - "/etc/localtime:/etc/localtime:ro"
      - "/etc/timezone:/etc/timezone:ro"
{{- end}}
      - "addons:/openhab/addons"
      - "conf:/openhab/conf"
      - "userdata:/openhab/userdata"

volumes:
  addons:
    driver: ${VOLUME_DRIVER}
    per_container: true
  conf:
    driver: ${VOLUME_DRIVER}
    per_container: true
  userdata:
    driver: ${VOLUME_DRIVER}
    per_container: true

