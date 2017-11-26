version: '2'
services:
  gitea:
    image: gitea/gitea:1.3.0-rc1
    volumes:
      - ${data_path}/git:/data/git
      - ${data_path}/ssh:/data/ssh
      - ${data_path}/gitea/conf:/data/gitea/conf
      - ${data_path}/gitea/lfs:/data/gitea/lfs
      - ${data_path}/gitea/log:/data/gitea/log
      - ${data_path}/gitea/sessions:/data/gitea/sessions

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
      - ${data_path}/gitea/db:/var/lib/mysql
{{- end}}
  lb:
    image: rancher/lb-service-haproxy:v0.7.9
    ports:
    - ${http_port}:${http_port}/tcp
    - ${ssh_port}:${ssh_port}/tcp
