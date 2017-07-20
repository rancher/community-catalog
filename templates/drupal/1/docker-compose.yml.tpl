version: '2'
services:
  drupal:
    image: drupal:8.3.5-apache
    labels:
      io.rancher.container.hostname_override: container_name
    links:
      - db:db
    volumes:
      - drupal-modules:/var/www/html/modules
      - drupal-profiles:/var/www/html/profiles
      - drupal-themes:/var/www/html/themes
      - drupal-sites:/var/www/html/sites
    restart: always

  drupal-lb:
    image: rancher/lb-service-haproxy:v0.6.4
    ports:
      - ${PUBLIC_PORT}:${PUBLIC_PORT}

  db:
    labels:
      io.rancher.container.hostname_override: container_name
  {{- if eq .Values.DB_TYPE "postgres"}}
    image: postgres:9.6.3-alpine
    environment:
      POSTGRES_USER:  ${DB_USER}
      POSTGRES_PASSWORD:  ${DB_PASS}
      POSTGRES_DB:  ${DB_NAME}
  {{- end}}
  {{- if eq .Values.DB_TYPE "mysql"}}
    image: mysql:5.7.18
    environment:
      MYSQL_DATABASE: ${DB_NAME}
      MYSQL_ROOT_PASSWORD: ${DB_PASS}
      MYSQL_USER: ${DB_USER}
      MYSQL_PASSWORD: ${DB_PASS}
  {{- end}}
    volumes:
    {{- if eq .Values.DB_TYPE "postgres"}}
      - db-data:/var/lib/postgresql
    {{- end}}
    {{- if eq .Values.DB_TYPE "mysql"}}
      - db-data:/var/lib/mysql
    {{- end}}
    restart: always

volumes:
  drupal-modules:
    driver: local
  drupal-profiles:
    driver: local
  drupal-themes:
    driver: local
  drupal-sites:
    driver: local
  db-data:
    driver: local

