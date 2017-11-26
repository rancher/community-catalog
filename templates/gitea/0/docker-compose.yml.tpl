version: '2'
services:
  gitea:
    image: gitea/gitea:1.3.0-rc1
    volumes:
      - gitea-data/git:/data/git
      - gitea-data/ssh:/data/ssh
      - gitea-data/gitea/conf:/data/gitea/lfs
      - gitea-data/gitea/lfs:/data/gitea/lfs
      - gitea-data/gitea/log:/data/gitea/log
      - gitea-data/gitea/sessions:/data/gitea/sessions

{{- if ne .Values.db_link ""}}
    external_links:
      - ${db_link}:db
{{- else}}
    links:
      - db:db
  db:
    image: mariadb:10
    environment:
      MYSQL_ROOT_PASSWORD: ${mysql_password}
      MYSQL_DATABASE: 'gitea'
    volumes:
      - gitea-db:/var/lib/mysql
{{- end}}
  lb:
    image: rancher/lb-service-haproxy:v0.7.9
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

