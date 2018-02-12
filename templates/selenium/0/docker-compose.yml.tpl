version: '2'
services:
  seleniumhub:
    image: selenium/hub:${SELENIUM_VERSION}
    environment:
      GRID_TIMEOUT: ${GRID_TIMEOUT}
    ports:
      - ${PUBLISH_PORT}:4444
  {{- if eq .Values.DEPLOY_SELENIUM_CHROME "true"}}
  selenium-chrome:
    image: selenium/node-chrome:${SELENIUM_VERSION}
    links:
    - seleniumhub:hub
  {{- end}}
  {{- if eq .Values.DEPLOY_SELENIUM_FIREFOX "true"}}
  selenium-firefox:
    image: selenium/node-firefox:${SELENIUM_VERSION}
    links:
    - seleniumhub:hub
  {{- end}}
