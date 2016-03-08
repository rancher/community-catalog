## Drone Rancher Node Manager

### Purpose:

This template will launch a global service and register the nodes as workers with Drone. 


The manager polls Rancher metadata service every 5 minutes and adds/removes nodes. One agent will run per host, and register a single worker.
