# Add Logspout Stack

Glider Labs Logspout with Logstash adapter

### Info:

For any services launched from the Rancher UI to use Logspout, please make sure to disable the '-t' [tty] option in the Advanced Options of the service definition. 

### Community Version

This version adds the Environment option, where you can specify the name of the Environment.
All Syslogs will then be sent with this as the Source Hostname rather than the hostname of
the Docker Host on which the container is running.
 
