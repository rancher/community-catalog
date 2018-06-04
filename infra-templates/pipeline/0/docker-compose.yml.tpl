{{- $jenkinsMasterImage:="jenkins/jenkins:2.60.2-alpine"}}
{{- $jenkinsBootImage:="rancher/jenkins-boot:v0.1.1"}}
{{- $jenkinsSlaveImage:="rancher/pipeline-jenkins-slave:v0.1.0"}}
{{- $pipelineServerImage:="rancher/pipeline:v0.1.0"}}
{{- $pipelineUIImage:="rancher/pipeline-ui:v0.1.0"}}

version: '2'
services:
  jenkins-master:
    image: {{$jenkinsMasterImage}}
    restart: always
    environment:
      - JENKINS_SLAVE_AGENT_PORT=50000
      - JENKINS_HOME=/var/jenkins_home
    volumes_from:
      - jenkins-boot
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    labels:
      io.rancher.sidekicks: jenkins-boot
      io.rancher.container.create_agent: true
      io.rancher.container.agent.role: environmentAdmin
  {{- if ne .Values.HOST_LABEL "" }}
      io.rancher.scheduler.affinity:host_label: ${HOST_LABEL}
  {{- end }}
  jenkins-boot:
    image: {{$jenkinsBootImage}}
    volumes:
      - jenkins_home:/var/jenkins_home
    labels:
      io.rancher.container.start_once: true
  jenkins-slave:
    image: {{$jenkinsSlaveImage}}
    restart: always
    links:
      - jenkins-master
    environment:
      - SLAVE_EXECUTORS=${EXECUTORS}
      - JENKINS_MASTER=http://jenkins-master:8080
      - JENKINS_USERNAME=admin
      - JENKINS_PASSWORD=admin
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - /var/jenkins_home
    labels:
      io.rancher.scheduler.affinity:container_label_soft_ne: io.rancher.stack_service.name=$${stack_name}/$${service_name}
      io.rancher.container.create_agent: true
      io.rancher.container.agent.role: environmentAdmin
      io.rancher.container.pull_image: always
  {{- if ne .Values.HOST_LABEL "" }}
      io.rancher.scheduler.affinity:host_label: ${HOST_LABEL}
  {{- end }}
  pipeline-server:
    image: {{$pipelineServerImage}}
    restart: always
    links:
      - jenkins-master
    environment:
      - JENKINS_ADDRESS=http://jenkins-master:8080
      - JENKINS_USER=admin
      - JENKINS_TOKEN=admin
    labels:
      io.rancher.container.create_agent: true
      io.rancher.container.agent.role: environmentAdmin
      io.rancher.container.pull_image: always
  {{- if ne .Values.HOST_LABEL "" }}
      io.rancher.scheduler.affinity:host_label: ${HOST_LABEL}
  {{- end }}
  pipeline-ui:
    image: {{$pipelineUIImage}}
    restart: always
    labels:
      io.rancher.container.create_agent: true
      io.rancher.container.agent.role: environment
      io.rancher.container.pull_image: always
      io.rancher.service.ui_link.label: "{\"en-us\":\"PIPELINE\",\"zh-hans\":\"流水线\"}"
  {{- if ne .Values.HOST_LABEL "" }}
      io.rancher.scheduler.affinity:host_label: ${HOST_LABEL}
  {{- end }}
volumes:
  jenkins_home:
    driver: "local"
