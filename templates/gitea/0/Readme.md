# Gitea - Git with a cup of tea

> A painless self-hosted Git service.

Gitea is a community managed fork of Gogs, lightweight code hosting solution written in Go and published under the MIT license.

## Installation

Note the mysql-root password from below, you will need it during installation.

When launching Gitea for the first time, you will greeted with an installer. You'll need to change two things: 

* The database settings:
  * Username: `root`
  * Password: the previously mentioned password
  * Database: `gitea`
  * Database Host: `db:3306`
* Change the public URL to the one you defined previously, this is needed to access Gitea's web UI.
