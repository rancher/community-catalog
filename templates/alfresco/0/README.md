# Alfresco

### Note:

If you can read French, you can look my [blog](https://blog.webcenter.fr) to look how to upgrade container after deployement for a production usage.

### Info:

This template deploys a collection of containers based upon the technologies below, once deployed you should have a
 Electronic Document Management (EDM) plateform based on Alfresco.
* **Alfresco** - Used to manage all aspect of EDM. (https://github.com/disaster37/rancher-alfresco)
* **Postgresql** - It's the SGBD to store metadatas of your EDM. (https://github.com/docker-library/postgres)

This template is just a base to test Alfresco. If you should use in production sky, You must upgrade it after install to setting it in your context (see all parameters you can use to set Alfresco on github). You must at minimal setting that :
* **Volume** : You must mount a database volume and alfresco volume on storage pool (convoy-gluster is a good idea).
  * For Postgresql `/var/lib/postgresql/data/pgdata`
  * For Alfresco `/opt/alfresco/alf_data`
* **Reverse Proxy / Load balancer** : You probably put load balancer like a endpoint for user. To do that, you must add extra parameter on your Alfresco container.
  * **REVERSE_PROXY_URL** : put your url like `https://ged.my-domain.com`
* **Mail setting** : There are a lot of parameter to set mail context.
* **CIFS setting** : There are a lot of parameter to set CIFS context.
* **LDAP authentification** : There are a lot of parameter to set LDAP authentification

All components in this stack are open source tools available in the community. All this template does is to bound them together in an easy to use package.



## Deployment:
* Select Alfresco from the community catalog.
* Click deploy.

## Usage
* Alfresco Share is now available on port 8080 with the following url `http://your_ip:8080/share`. Authentication is with the default `admin/admin`.
