# XPilots

This creates an X-Windows base X-Pilots game, for testing X-Windows connectivity.  To use this, you will need to have X-Windows installed on your workstation, and able to accept incoming connections from the Docker Hosts.

For the client, you need to specify the location of your X-Windows desktop, for example 1.2.3.4:0

You can add more players by just cloning the first player service, and giving it different DISPLAY and NAME environment variable settings.

Note that there are NO publicly exposed ports as it runs purely over the Rancher
private network!  If you want to make this available to external players, you
need to expose the port 15345/udp from the Server container.

