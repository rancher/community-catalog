version: '2'
services:
  wekan:
    image: mquandalle/wekan
    restart: always
    labels:
      traefik.enable: true
      traefik.alias: ${WEKAN_HOST}
      traefik.domain: ${WEKAN_DOMAIN}
      traefik.acme: true
      traefik.port: 80
    {{- if ne .Values.host_label ""}}
      io.rancher.scheduler.affinity:host_label: ${host_label}
    {{- end}}
    environment:
      MONGO_URL: "mongodb://mongo/${MONGO_DB}"
      ROOT_URL: "http://${WEKAN_HOST}.${WEKAN_DOMAIN}"
{{- if ne .Values.mongo_link ""}}
    external_links:
      - ${mongo_link}:mongo
    tty: true
{{- else}}
  mongo:
    command: mongod --storageEngine=wiredTiger
    restart: always
    environment:
      MONGO_SERVICE_NAME: mongo
      CATTLE_SCRIPT_DEBUG: ${debug}
    tty: true
    image: mongo:3.4
    labels:
      io.rancher.container.hostname_override: container_name
    {{- if ne .Values.host_label ""}}
      io.rancher.scheduler.affinity:host_label: ${host_label}
    {{- end}}
    volumes:
      - mongodata:/data/db
volumes:
  mongodata:
    driver: ${VOLUME_DRIVER}
    per_container: true
{{- end}}
