version: '2'

services:

  artifactory:
    image: docker.bintray.io/jfrog/artifactory-oss:5.4.4
    {{- if (.Values.PUBLISH_PORT)}}
    ports:
      - ${PUBLISH_PORT}:8081
    {{- else}}
    expose:
      - 8081
    {{- end}}
    volumes:
     - artifactory-data:/var/opt/jfrog/artifactory
    environment:
     - EXTRA_JAVA_OPTIONS=${EXTRA_JAVA_OPTIONS}

volumes:
  artifactory-data:
    driver: ${VOLUME_DRIVER}

