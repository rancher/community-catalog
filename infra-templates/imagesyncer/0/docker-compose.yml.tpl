version: '2'
services:
  imagesyncer:
    image: superseb/imagesyncer:0.1.0
    {{- if eq .Values.PRIVILEGED "true"}}
    privileged: true
    {{- end}}
    environment:
      CHECK_CPU_USAGE: ${CHECK_CPU_USAGE}
      CHECK_INTERVAL: ${CHECK_INTERVAL}
      CPU_USAGE_MAX: ${CPU_USAGE_MAX}
      CPU_USAGE_SLEEP: ${CPU_USAGE_SLEEP}
      RANDOM_SLEEP: ${RANDOM_SLEEP}
    stdin_open: true
    volumes:
    - /var/run/docker.sock:/var/run/docker.sock
    {{- if eq .Values.MOUNT_DOCKER_CONFIG "true"}}
    - ${DOCKER_CONFIG_LOCATION}:/root/.docker/config.json
    {{- end}}
    tty: true
    labels:
      io.rancher.container.agent.role: environment
      io.rancher.container.create_agent: 'true'
      io.rancher.scheduler.global: 'true'
