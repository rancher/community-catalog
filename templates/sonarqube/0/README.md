## What is inside SonarQube Stack?
* [SonarQube Server](http://www.sonarqube.org/) + Sidekick for storing plugins
* Postgres Database + Sidekick for storing data

## Info
* In default SonarQube stack will create "sonar" postgres database with sonar user.  
* Additional variables `http_proxy` and `https_proxy` are included, which can be helpfull in some cases.
* Once SonarQube will start, make sure you setup correct information in setup page.
* For easy upgrades there are sidekicks for both postgress and SonarQube with dedicated storage.

## Installing Plugins Manually
* Go to [Plugin Library](http://docs.sonarqube.org/display/PLUG/Plugin+Library) and find your favourite plugins
* Execute `docker exec -it [sonarqube-data bash]`, go to /opt/sonarqube/extensions/plugins and put your plugins here
* Restart SonarQube container.

## First Start
* Use admin/admin to login to the SonarQube interface.
