version: '2'
services:
  zinst-repository:
    image: zinst/zinst_repository:0.5
    volumes:
    - zinst-data:/data/dist
  zinst-lb:
    image: rancher/lb-service-haproxy:v0.7.6
    ports:
    - ${http_port}:${http_port}/tcp
volumes:
  zinst-data:
    driver: ${volume_driver}
    
    
