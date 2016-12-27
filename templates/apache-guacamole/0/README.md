# Apache Guacamole

Apache Guacamole is a clientless remote desktop gateway. It supports standard protocols like VNC, RDP, and SSH.
We call it clientless because no plugins or client software are required.
Thanks to HTML5, once Guacamole is installed on a server, all you need to access your desktops is a web browser.

This service uses the official Apache [http://guacamole.incubator.apache.org](https://hub.docker.com/r/glyptodon/guacamole/) Guacamole image. It also uses the official MariaDB image as its backend.
Health checks are enabled on all services.

## How to use

Using all default settings will work. The MySQL root password is randomly generated and has "one time password" set.
After starting, the initial database setup will be executed by a runonce container.
The default login will be `guacadmin/guacadmin`.

This stack exposes Guacamole on port 8080 by default. You can use it as it is, or map a load balancer to it and not expose the port.

Once all containers are running, Guacamole is available on `http://[container_ip]:8080/`.
If the page is blank, try refreshing the page after 5-10 seconds, since the database container might still be initializing.