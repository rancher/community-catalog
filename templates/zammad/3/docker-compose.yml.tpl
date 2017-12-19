version: '2'

services:

  zammad-backup:
    command: ["zammad-backup"]
    depends_on:
      - zammad-railsserver
    entrypoint: /usr/local/bin/backup.sh
    image: zammad/zammad-docker-compose:zammad-postgresql-2.2.0-12
    links:
      - zammad-postgresql
    restart: always
    volumes:
      - zammad-backup:/var/tmp/zammad
      - zammad-data:/opt/zammad

  zammad-elasticsearch:
    image: zammad/zammad-docker-compose:zammad-elasticsearch-2.2.0-12
    labels:
      io.rancher.sidekicks: {{- if eq .Values.UPDATE_SYSCTL "true" -}}zammad-es-sysctl{{- end}}
    restart: always
    volumes:
      - elasticsearch-data:/usr/share/elasticsearch/data

  zammad-init:
    command: ["zammad-init"]
    depends_on:
      - zammad-postgresql
    image: zammad/zammad-docker-compose:zammad-2.2.0-12
    labels:
      io.rancher.container.start_once: true
    links:
      - zammad-elasticsearch
      - zammad-postgresql
    restart: on-failure
    volumes:
      - zammad-data:/opt/zammad

  zammad-memcached:
    command: ["zammad-memcached"]
    image: zammad/zammad-docker-compose:zammad-memcached-2.2.0-12
    restart: always

  zammad-nginx:
    command: ["zammad-nginx"]
    depends_on:
      - zammad-railsserver
    image: zammad/zammad-docker-compose:zammad-2.2.0-12
    links:
      - zammad-railsserver
      - zammad-websocket
    restart: always
    volumes:
      - zammad-data:/opt/zammad

  zammad-postgresql:
    image: zammad/zammad-docker-compose:zammad-postgresql-2.2.0-12
    restart: always
    volumes:
      - postgresql-data:/var/lib/postgresql/data

  zammad-railsserver:
    command: ["zammad-railsserver"]
    depends_on:
      - zammad-memcached
      - zammad-postgresql
    image: zammad/zammad-docker-compose:zammad-2.2.0-12
    links:
      - zammad-elasticsearch
      - zammad-memcached
      - zammad-postgresql
    restart: always
    volumes:
      - zammad-data:/opt/zammad

  zammad-scheduler:
    command: ["zammad-scheduler"]
    depends_on:
      - zammad-memcached
      - zammad-railsserver
    image: zammad/zammad-docker-compose:zammad-2.2.0-12
    links:
      - zammad-elasticsearch
      - zammad-memcached
      - zammad-postgresql
    restart: always
    volumes:
      - zammad-data:/opt/zammad

  zammad-websocket:
    command: ["zammad-websocket"]
    depends_on:
      - zammad-memcached
      - zammad-railsserver
    image: zammad/zammad-docker-compose:zammad-2.2.0-12
    links:
      - zammad-postgresql
      - zammad-memcached
    restart: always
    volumes:
      - zammad-data:/opt/zammad

  {{- if eq .Values.UPDATE_SYSCTL "true" }}
  zammad-es-sysctl:
    labels:
        io.rancher.container.start_once: true
    network_mode: none
    image: rawmind/alpine-sysctl:0.1
    privileged: true
    environment:
        - "SYSCTL_KEY=vm.max_map_count"
        - "SYSCTL_VALUE=262144"
  {{- end}}

  zammad-lb:
    image: rancher/lb-service-haproxy:v0.7.15
    ports:
      - 9797:9797/tcp
    labels:
      io.rancher.container.agent.role: environmentAdmin,agent
      io.rancher.container.agent_service.drain_provider: 'true'
      io.rancher.container.create_agent: 'true'

volumes:
  elasticsearch-data:
    driver: local
  postgresql-data:
    driver: local
  zammad-backup:
    driver: local
  zammad-data:
    driver: local
