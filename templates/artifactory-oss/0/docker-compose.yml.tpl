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
  {{- if (.Values.PUBLISH_PORT)}}
  artifactory-lb:
    image: rancher/lb-service-haproxy:v0.6.4
    ports:
      - ${PUBLISH_PORT}:${PUBLISH_PORT}
  {{- end}}
volumes:
  artifactory-data:
    driver: ${VOLUME_DRIVER}

