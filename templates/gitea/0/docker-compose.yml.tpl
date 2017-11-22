version: '2'
services:
  gitea:
    image: gitea/gitea:1.3
    volumes:
      - gitea-data:/data
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
      - gitea-db:/var/lib/mysql
{{- end}}
  lb:
    image: rancher/lb-service-haproxy:v0.6.4
    ports:
    - ${http_port}:${http_port}/tcp
    - ${ssh_port}:${ssh_port}/tcp
volumes:
  gitea-data:
    driver: ${volume_driver}
{{- if eq .Values.db_link ""}}
  gitea-db:
    driver: ${volume_driver}
{{- end}}

