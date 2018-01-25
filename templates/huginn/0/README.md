# Huginn

Your agents are standing by!

[Huginn](https://github.com/huginn/huginn) is a tool that allows you to automate tasks on the internet and/or your private intranet.

## Installation

When huginn first starts up it will create one user named, `admin`, with the password, `password`, along with a number of example agents for that user. Each new user will start off with a set of example agents.

**Warning**: The **Require Confirmed Email** option *must* be **off** when you first start up the stack because the default user has a fake email address and will not allow you to login. If desired, you can upgrade the stack and turn email verification back on after changing the admin's email address.

The Huggin web interface is served in the `huginn_web` container on port `3000`. In order to get web traffic to the container you have to create a Rancher load balancer and route the traffic to the container on port `3000`.

## Scaling

The `huginn-web` service *can* be scaled to provide a redundant web interface or to account for a large amount of traffic, but scaling is usually unnecessary.

The `huginn-agent-runner` service **cannot** be scaled as it is the agent scheduler. Running multiple `huginn-agent-runner` services would result in jobs running multiple times. Running only a single `huginn-agent-runner` container should not be a HA concern because the container does not represent any significant load and because the container will restart automatically in case of a failure. In the event of a container restart, there will a momentary pause in agent scheduling, but that should not represent any issue.

The `huginn-delayed-job` service can and should be scaled up if you have a large number of agents. This will distribute the tasks over more containers.

## Configuration

For more information on configuration options see [this example environment file](https://github.com/huginn/huginn/blob/master/.env.example) from the Huginn project.
