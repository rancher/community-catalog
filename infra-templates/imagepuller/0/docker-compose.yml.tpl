version: '2'
services:
  imagepuller:
    image: superseb/imagepuller:0.1.5
    {{- if eq .Values.PRIVILEGED "true"}}
    privileged: true
    {{- end}}
    environment:
      CHECK_CPU_USAGE: ${CHECK_CPU_USAGE}
      CPU_USAGE_MAX: ${CPU_USAGE_MAX}
      CPU_USAGE_SLEEP: ${CPU_USAGE_SLEEP}
      RANCHER_VERSION: ${RANCHER_VERSION}
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
      io.rancher.container.start_once: 'true'
      io.rancher.container.create_agent: 'true'
      io.rancher.scheduler.global: 'true'
