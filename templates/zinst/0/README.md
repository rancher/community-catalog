
# Zinst
## Install
* Git clone 1st
```
git clone https://github.com/goody80/zinst_repository_docker.git
```

* Git clone for zinst packages (optional)
```
git clone https://github.com/goody80/Zinst_packages.git
cp -Rfv ./Zinst_packages/* ./zinst_repository_docker/dist/
```


## Use
* How to start the zinst repository server
```
cd zinst_repository_docker
docker-compose up -d
```

* How to set the zinst client
```
curl -sL bit.ly/online-install  |bash
zinst self-config ip=[IP address of the docker Host] host=[Hostname of docker host]:8080
```

* check the server alive
```
zinst find
```

## Setup
* You can modify the docker-compose.yml for setup as below
    * for example: I need to change the port 8080 to 80. - You can do as below
    * `8080:80/tcp` -> `80:80/tcp`

```
version: '2'
services:
  zinst-repository:
    image: zinst/zinst_repository:latest
    ports:
    - 8080:80/tcp
    volumes:
    - ./dist:/data/dist:rw
```

## What is the Zinst ?
### zinst?
* Package install manager. It very similar that concept of yinst command in Yahoo!

### Summary
* For the centralized package manage & distributed systems
  * Centralized control:
    * Install the Package to the destination server 
      * *ex) zinst install apache_server-1.0.1.zinst apache_conf-1.0.1.zinst -h web0[1-7,9]* 
    * list-up the package in each server 
      * *ex) zinst ls*
    * list-up the file of package in each server 
      * *ex) zinst ls -files apache_server*
    * Easy find out the installed package-name of a some distributed file 
      * *ex) zinst ls -files /data/z/httpd/conf/include/_temp.conf*
    * Can tracking the release history with who could controlled
      * *ex) zinst history*
    * Easy can change the configuration setup 
      * *ex) zinst set apache_conf.maxclient=64*
      * Then you can see the configuration has been changed on the Apache server for example.
    * Package remove
    * Send a command to the distributed systems
      * *ex) zinst ssh "whoami" -h web[0-1][0-9], web20*
    * Can makes a list of multiple host for the target control
      * *ex) zinst ssh "whoami" -H ./hostlist.txt* 
    * One package, can makes a differnt output
      * *ex) zinst install apache_server -set apache_server.maxclient=32 -h web01 web02*
      *     *zinst install apache_server -set apache_server.maxclient=64 -h news01 news02*
    * Daemon controll
      * *ex) zinst start httpd*
      * Then we can recognize that who managed the daemon in the server as a history
    * Easy to find out the package has been released to somewhere
      * *ex) zinst track hwconfig-1.
    * Supported a package restore & roll-back as a save file
      * *ex) zinst restore -file /data/z/save/zinst-save.56*
    * Without difficult language and environment. Due to it made by Bash only
