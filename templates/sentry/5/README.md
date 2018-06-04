# Sentry


### Info:
 This templates creates a complete [sentry](https://github.com/getsentry/sentry) setup including postgres and redis servers.

 Images are the offical images from:
 * Sentry: [https://hub.docker.com/_/sentry/](https://hub.docker.com/_/sentry/)
 * Postgres: [https://hub.docker.com/_/postgres/](https://hub.docker.com/_/postgres/)
 * Redis: [https://hub.docker.com/_/redis/](https://hub.docker.com/_/redis/)

### Usage:

 * Select Sentry from catalog.

 * Required
   * Enter a sentry secret
   * Specify the email and password of the initial user

 * Optional
   * Specify an external database host \*
   * Email configuration

 * Click deploy.

\* If you specify an external database, you will want to delete the "sentry-postgres" service after creating the Sentry stack.
