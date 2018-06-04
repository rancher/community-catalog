
# Zinst
## Install
1. How to install the zinst client
```
curl -sL bit.ly/online-install  |bash
zinst self-config ip=[IP address of the zinst-repository] host=[Hostname of zinst-repository]:[http_port]
```

2. check the server alive
```
zinst find
```

3. You can clone and copy the open-source zinst packages from the Github to the Volume dircetory as below.
 * https://github.com/goody80/Zinst_packages


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


