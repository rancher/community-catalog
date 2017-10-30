# AWS Spot Instance Helper

### Info
This is a simple service that runs globally. It monitors the state of the host, if the host is running on a spot instance it will check to see if the host is scheduled for termination then it will automatically deactive the host and evaculate the containers.

The source code is available at [https://www.github.com/chrisurwin/aws-spot-instance-helper](https://www.github.com/chrisurwin/aws-spot-instance-helper)

This version support notification to slack.

