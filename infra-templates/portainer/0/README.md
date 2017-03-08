**_Portainer_** is a lightweight management UI which allows you to **easily** manage your Docker host or Swarm cluster.

**_Portainer_** is meant to be as **simple** to deploy as it is to use. It consists of a single container that can run on any Docker engine (Docker for Linux and Docker for Windows are supported).

**_Portainer_** allows you to manage your Docker containers, images, volumes, networks and more ! It is compatible with the *standalone Docker* engine and with *Docker Swarm*.

## Getting started

Once you have deploy the stack you can access the Portainer UI at `http://<RANCHER SERVER>/r/projects/<PROJECT ID>/portainer/`.
For example

    http://rancher-server:8080/r/projects/1a5/portainer/

Note, the trailing / is important in the URL

## Demo

<img src="http://portainer.io/images/screenshots/portainer.gif" width="77%"/>

You can try out the public demo instance: http://demo.portainer.io/ (login with the username **demo** and the password **tryportainer**).

Please note that the public demo cluster is **reset every 15min**.

## Getting help

* Documentation: https://portainer.readthedocs.io
* Issues: https://github.com/portainer/portainer/issues
* FAQ: https://portainer.readthedocs.io/en/latest/faq.html
* Gitter (chat): https://gitter.im/portainer/Lobby
* Slack: http://portainer.io/slack/

## Reporting bugs and contributing

* Want to report a bug or request a feature? Please open [an issue](https://github.com/portainer/portainer/issues/new).
* Want to help us build **_portainer_**? Follow our [contribution guidelines](https://portainer.readthedocs.io/en/latest/contribute.html) to build it  locally and make a pull request. We need all the help we can get!

## Limitations

**_Portainer_** has full support for the following Docker versions:

* Docker 1.10 to Docker 1.12 (including `swarm-mode`)
* Docker Swarm >= 1.2.3

Partial support for the following Docker versions (some features may not be available):

* Docker 1.9
