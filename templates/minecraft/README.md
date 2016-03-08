# Minecraft

### Topology

This will start up several Minecraft servers of the specified type.  If no
world seed is specified, then a random one will be used.  A Load Balancer
will be created over the top so that they can be accessed.

The servers use ephemeral disk and so will not be persistent.  You can also 
specify a URL from which to download an ZIP archive of a world save, which
will be used in all containers.

### Options

You **must** accept the [EULA](https://account.mojang.com/documents/minecraft_eula) by selecting **TRUE** in the dropdown.

You should specify a unique port number for the load balancers to listen on.

The other options for the server may be left as their defaults.
