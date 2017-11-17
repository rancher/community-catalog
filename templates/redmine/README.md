[Redmine](https://www.redmine.org/)

Redmine is a flexible project management web application. Written using
the Ruby on Rails framework, it is cross-platform and cross-database.

This rancher template should get you a redmine container up and running
to test.  To see other implementations, including postgres, and using convoy for persistent data see
the catalog [here](https://github.com/webhostingcoopteam/whc-catalog)

For external access you'll need to setup [traefik](https://github.com/rancher/community-catalog/tree/master/templates/traefik), all the appropriate
labels will be set when you set the hostname and domain below
