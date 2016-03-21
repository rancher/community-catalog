# Drone

### Info:

This template creates an instance of Drone CI server 0.4.

### Usage:

Select the Drone template from the catalog. Provide the following information:

1. Database driver
2. Database configuration: this will look like either a path `/var/lib/drone/sqlite3` or a connection string `<user>:<password>@tcp(database:<port>)<database>?parseTime=true`
The name will always be database.
3. Remote repository store. (Ie. GitHub)
4. Remote repository store configuration.

See [Drone documentation](http://readme.drone.io/setup/overview/) for complete information.
