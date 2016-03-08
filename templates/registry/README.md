# Registry

This catalogue item consists of a Registry, and the Portus web UI for 
authentication.  There is also a MySQL database for storage, and a nginx
proxy to provide SSL for the web frontend.

A directory path is required for storage of the Registry data, Database,
Certificates and generated Nginx configuration files.  If you have 
multiple Hosts then this needs to be a shared mount across all Hosts which
will run any of these containers.

If no certificates are provided in the /certs directory, then the system 
will generate self-signed SSL certificates to use.

Note that the containers will take a significant amount of time to initialse after 
they are started.  You may need to wait 15 minutes for the Portus instance
to finally spot the registry instance and perform its first synchronisation,
after which the web interface will come online.

## Backing Store

A persistent shared filesystem is required to host the Registry, and also the 
MySQL database.  This will also hold the certificates under certs/server.crt
and certs/server.key; if no certificate is present, then a self-signed
certificate will be created (valid for one year only) that can later be 
replaced.

## LDAP Authentication

If you enable LDAP authentication, then this will be used for both the
Web interface and for Registry authentication.  The LDAP configuration
may optionally have authenticated Bind credentials, and TLS options.

## Security

All connections are protected by SSL.  A self-signed certificate is
automatically generated as certs/server.crt and certs/server.key in 
the persistent shared storage; this can be replaced if necessary.

The certificate is used for registry access, for web admin access,
and for signing API access keys.

Registry access is controlled by the same user access as the web interface;
so if you link to LDAP then this will also lock the Registry access.

If not using LDAP, then the 'portus' use password is the Database Password
as defined in the template options.

## Access

The template will create a Load Balancer for access to the Registry and
to the Web Admin interface.  This will run on all Hosts with the label 
LB=1, listening on the defined ports.

To access the web UI, use https on the hostname and port you configured.

To upload to the repository, use an SSL connection to the hostname and
registry port you configured.

## Administration

The first user to log in to the web interface will be granted Admin
privileges.

## Synchronisation with Registry

The Web interface will be initially configured to use the incorporated 
registry.  A periodic synchronisation task and the upload webhook will
ensure they are in synch.  If, for some reason, your registry already 
has items (for example, if you are recreating the stack on preexisting
shared storage) then it may take up to 5min for the Portus Web UI to 
synchronise the registry content to its database.

## Feedback

This is a complex setup, and uses a custom build of the Portus container,
which is not yet available as an official release.  You may need to
customise this heavily for your own site.  Any feedback can
be logged against https://github.com/sshipway/Portus
