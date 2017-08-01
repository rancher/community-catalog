## What is inside WordPress Stack?
* MariaDB Database
* WordPress (php/apache)
* Rancher Load Balancer (haproxy)

## Info
* To persist website and database data, two volumes are created: mariadb_data, wordpress_data.
* You can choose from one of existing rancher volume types depending on your own environment.

## Compatibility Notes

* Version v0.2-bitnami has some known [issue](https://github.com/bitnami/bitnami-docker-testlink/issues/17#issuecomment-261783035) with Docker overlay and overlay2 storage driver. Please try to switch to aufs or devicemapper.
