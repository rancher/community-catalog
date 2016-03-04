# Minecraft

### Topology

This will start up several Minecraft servers of the specified type.  If no
world seed is specified, then a random one will be used.  A Load Balancer
will be created over the top so that they can be accessed.

The load balancers will run on every host with the label **LB=1**.  If
no hosts match this, then you will get no load balancers!

### Options

You **must** accept the [EULA](https://account.mojang.com/documents/minecraft_eula) by selecting **TRUE** in the dropdown.

You should specify a unique port number for the load balancers to listen on.

The other options for the server may be left as their defaults.
