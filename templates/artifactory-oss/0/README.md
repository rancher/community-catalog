# Artifactory 
	
[Artifactory][artifactory] is a universal Binary Repository Manager for use by build tools (like Maven and Gradle), 
dependency management tools (like Ivy and NuGet) and build servers (like Jenkins, Hudson, TeamCity and Bamboo).
 
Repository managers serve two purposes: they act as highly configurable proxies between your organization and 
external repositories and they also provide build servers with a deployment destination for your internally 
generated artifacts.

### Usage:

 - Select Artifactory from catalog. 
 - Select artifactory version. 
 - Select artifactory release, OSS or PRO.
 - Set the params and select certificate.

 Click "Launch".

### Notes:

- To use the PRO version, you need to get a free trial.
- You need a certificate imported in rancher enviroment before deploy this package. 
- If you use self signed certificates, you should implement [self-signed-certificates][using-self-signed-certificates] in your hosts.
- If you use http schema, you should implement [insecure-registry][insecure-registry] in your hosts.
- KNOWN LIMITATION: "SSL certificate" is required for http and https publish schema.


### More info:

- [Resources][artifactory-resources]
- [Free-trial][artifactory-trial]
- [Self-signed-certificates][using-self-signed-certificates]
- [Insecure-registry][insecure-registry]


[artifactory]: https://www.jfrog.com/artifactory/
[artifactory-resources]: https://www.jfrog.com/support-service/resources/
[artifactory-trial]: https://www.jfrog.com/artifactory/free-trial/
[using-self-signed-certificates]: https://docs.docker.com/registry/insecure/#using-self-signed-certificates
[insecure-registry]: https://docs.docker.com/registry/insecure/# Artifactory 
	