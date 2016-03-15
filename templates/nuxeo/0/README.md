# Nuxeo


This templates deploys a Nuxeo server with all its companions (Elasticsearch, Redis and Postgres) to be able to run Nuxeo on top of you Rancher infrastructure


# How to use it ?

Just create and launch the stack. After that, you have to point a load balancer of you infrasctructure to the internal stack load balancer. 

We made this choice, since it allows to start several Nuxeo server instance on the same infrastructure.

After that you can login with the regular user/password combination Administrator/Administrator.