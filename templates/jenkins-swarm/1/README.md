## Jenkins Swarm Plugin Clients
### Experimental


### Info:

This template deploys Jenkins Swarm Clients through Rancher. These clients will come up and imediately be available for running Jenkins jobs. 

### Requires

Docker 1.9.1 - This image bundles in Docker 1.9.1 and bind mounts the host Docker socket. This means it will unfortunately fail on clients older then Docker 1.9.1.

### Usage

User: If you plan to use Jenkins Swarm plugin AND Docker you need to use `root`. If you are not going to use Docker, you can run as the `jenkins` user. The `jenkins` user does not have access ot the Docker socket.

Jenkins User: If authentication is turned on, you will need to supply the username the swarm clients should login with.

Jenkins Password: If authentication is turned on, you will need to supply the password the swarm clients should use.

swarm executors: Number of build jobs to run on the client. The default is the number of CPUs.