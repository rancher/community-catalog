# Autospotting

### Info
This service builds upon the open source autospotting at [https://github.com/cristim/autospotting](https://github.com/cristim/autospotting)

This has been turned into a Rancher catalog entry with a couple of minor tweaks and the removal of the requirement to run it as a lambda function, it now runs as a docker container.

Autospotting works by taking a tag that you specify and adding it to an AWS Auto-Scaling Group with a value of true.

The container will then run and check for on-demand instances and replace them with cheap spot instances. This is a gradual process and will only replace one host in an ASG at a time.

