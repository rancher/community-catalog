# DokuWiki

DokuWiki is a simple to use and highly versatile Open Source wiki software that doesn't require a database.

## Version
The Stack is based on DokuWiki Version 2016-06-26a "Elenor of Tsort"

Check out the underlying dockerfile here: https://hub.docker.com/r/ununseptium/dokuwiki-docker

## Setup
To initialize the dokuwiki you have to run the install.php script. The url scheme to get to the install script would be:

`http(s)://dockerhostip:exposedport/install.php`

If you want to use the dokuwiki in production please remove the install.php before doing so:

`docker exec {containeridentifier} rm /var/www/html/install.php`
