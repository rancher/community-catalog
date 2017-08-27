version: '2'
services:
  gogs:
    image: gogs/gogs:0.11.19
    volumes:
      - gogs-data:/data
{{- if ne .Values.db_link ""}}
    external_links:
      - ${db_link}:db
{{- else}}
    links:
      - db:db
  db:
    image: mysql:5.5
    environment:
      MYSQL_ROOT_PASSWORD: ${mysql_password}
      MYSQL_USER: ${mysql_user}
      MYSQL_PASSWORD: ${mysql_password}
      MYSQL_DATABASE: ${mysql_db}
    volumes:
      - gogs-db:/var/lib/mysql
{{- end}}
  lb:
    image: rancher/lb-service-haproxy:v0.6.4
    ports:
    - ${http_port}:${http_port}/tcp
    - ${ssh_port}:${ssh_port}/tcp
volumes:
  gogs-data:
    driver: ${volume_driver}
{{- if eq .Values.db_link ""}}
  gogs-db:
    driver: ${volume_driver}
{{- end}}

