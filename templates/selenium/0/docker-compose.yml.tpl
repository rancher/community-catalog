version: '2'
services:
  {{- if eq .Values.DEPLOY_SELENIUM_HUB "true"}}
  seleniumhub:
    image: selenium/hub:${SELENIUM_HUB_VERSION}
    environment:
      GRID_TIMEOUT: ${GRID_TIMEOUT}
    labels:
      io.rancher.container.pull_image: always
  {{- end}}
  {{- if eq .Values.DEPLOY_SELENIUM_CHROME "true"}}
  selenium-chrome:
    image: selenium/node-chrome:${SELENIUM_CHROME_VERSION}
    links:
    - seleniumhub:hub
    labels:
      io.rancher.container.pull_image: always
  {{- end}}
  {{- if eq .Values.DEPLOY_SELENIUM_FIREFOX "true"}}
  selenium-firefox:
    image: selenium/node-firefox:${SELENIUM_FIREFOX_VERSION}
    links:
    - seleniumhub:hub
    labels:
      io.rancher.container.pull_image: always
  {{- end}}
