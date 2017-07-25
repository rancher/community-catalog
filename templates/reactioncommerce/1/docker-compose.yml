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
      MONGO_URL: ${MONGO_URL}
      ROOT_URL: "http://${REACTION_HOST}.${REACTION_DOMAIN}"
      REACTION_EMAIL: ${REACTION_EMAIL}
      REACTION_USER: ${REACTION_USER}
      REACTION_AUTH: ${REACTION_AUTH}
    external_links:
      - ${mongo_link}:mongo
