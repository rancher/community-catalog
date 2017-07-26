version: '2'
services:
  reaction:
    image: reactioncommerce/reaction:v1.4.0
    restart: always
    labels:
      io.rancher.scheduler.affinity:host_label: ${host_label}
      traefik.enable: true
      traefik.alias: ${REACTION_HOST}
      traefik.domain: ${REACTION_DOMAIN}
      traefik.acme: true
      traefik.port: 3000
    environment:
      MONGO_URL: "mongodb://mongo/${MONGO_DB}"
      ROOT_URL: "http://${REACTION_HOST}.${REACTION_DOMAIN}"
      REACTION_EMAIL: ${REACTION_EMAIL}
      REACTION_USER: ${REACTION_USER}
      REACTION_AUTH: ${REACTION_AUTH}
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
      io.rancher.scheduler.affinity:host_label: ${host_label}
      io.rancher.container.hostname_override: container_name
    volumes:
      - mongodata:/data/db
volumes:
  mongodata:
    driver: ${VOLUME_DRIVER}
{{- end}}
