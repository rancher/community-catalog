version: '2'
services:
  artifactory:
    {{- if eq .Values.ARTIFACTORY_VERSION "OSS"}}
    image: docker.bintray.io/jfrog/artifactory-oss:5.4.5
    {{- else}}
    image: docker.bintray.io/jfrog/artifactory-pro:5.4.5
    {{- end}}
    volumes:
     - artifactory-data:/var/opt/jfrog/artifactory
    environment:
     - EXTRA_JAVA_OPTIONS=${EXTRA_JAVA_OPTIONS}
  artifactory-rp:
    image: rawmind/alpine-nginx:1.12.1-3
    external_links:
      - artifactory:artifactory
    environment:
      NGINX_SERVER_NAME: artifactory
      NGINX_SERVER_CONF: |
        server {
    
          listen ${PUBLISH_PORT};
          server_name ~(?<repo>.+)\.${PUBLISH_NAME} ${PUBLISH_NAME};
    
          set $$http_x_forwarded_proto  ${PUBLISH_SCHEMA};

          ## Application specific logs
          ## access_log /var/log/nginx/oss.local-access.log timing;
          ## error_log /var/log/nginx/oss.local-error.log;

          chunked_transfer_encoding on;
          client_max_body_size 0;

          proxy_read_timeout  900;
          proxy_pass_header   Server;
          proxy_cookie_path   ~*^/.* /;

          location  /v2 {
            proxy_pass          http://artifactory:8081/artifactory/api/docker/$$repo/v2/;
          }
          location / {
            proxy_pass          http://artifactory:8081/artifactory/;
          }
          proxy_set_header    X-Artifactory-Override-Base-Url $$http_x_forwarded_proto://$$host:$$server_port;
          proxy_set_header    X-Forwarded-Port  $$server_port;
          proxy_set_header    X-Forwarded-Proto $$http_x_forwarded_proto;
          proxy_set_header    Host              $$http_host;
          proxy_set_header    X-Forwarded-For   $$proxy_add_x_forwarded_for;
        }
  {{- if (.Values.PUBLISH_PORT)}}
  artifactory-lb:
    image: rancher/lb-service-haproxy:v0.6.4
    ports:
      - ${PUBLISH_PORT}:${PUBLISH_PORT}
  {{- end}}
volumes:
  artifactory-data:
    driver: ${VOLUME_DRIVER}

