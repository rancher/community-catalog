# RabbitMQ Examples

I needed to test a rabbitMQ with some basics so I forked the official tutorials and added a Dockerfile
[here](https://github.com/joshuacox/rabbitmq-tutorials/tree/jsdockerfile/javascript-nodejs)

[dockerhub here](https://hub.docker.com/r/joshuacox/rabbitmq-tutorials/)

In that fork, there is a `Makefile` that can run through the proof of
concept.  `make` will start a rabbitmq container, then start all the
listeners as deamons, and the emitters to run once.  The emitters are
ephemeral and will go away once their message is sent or they error out.
