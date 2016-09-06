## What is inside TeamCity Stack?
* TeamCity Server
* Postgres Database
* Scalable TeamCity Agents

## Info
* In default TeamCity stack will create "teamcity" postgres database with teamcity user.  
* Additional variables `http_proxy` and `https_proxy` are included, which can be helpfull in some cases.
* Once TeamCity will start, make sure you setup correct information in setup page.
* For easy upgrades there are sidekicks for both postgress and teamcity-server with dedicated storage.

## TeamCity Agents
TeamCity Agents will start automatically and connect to the TeamCity Server.  
Agents should be available in TeamCity Server in about 5 minutes after stack's start.
