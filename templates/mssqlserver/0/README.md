# Microsoft Sqlserver 2017

Before you start, please read this first.

### ACCEPT_EULA

the container of this package will start with 'ACCEPT_EULA=Y' environment variable.
Which means you accepted the [EULA](https://go.microsoft.com/fwlink/?linkid=857698) from Microsoft.

By passing the value "Y" to the environment variable "ACCEPT_EULA", you are expressing that you have a valid and existing license for the edition and version of SQL Server that you intend to use. You also agree that your use of SQL Server software running in a Docker container image will be governed by the terms of your SQL Server license.


### MSSQL_PID

MSSQL_PID is the Product ID (PID) or Edition that the container will run with. Acceptable values:

* Developer : This will run the container using the Developer Edition (this is the default if no MSSQL_PID environment variable is supplied)
* Express : This will run the container using the Express Edition
* Standard : This will run the container using the Standard Edition
* Enterprise : This will run the container using the Enterprise Edition
* EnterpriseCore : This will run the container using the Enterprise Edition Core

For a complete list of environment variables that can be used, refer to the documentation here 

[https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker](https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker).

### SA_PASSWORD

A strong system administrator (SA) password: At least 8 characters including uppercase, lowercase letters, base-10 digits and/or non-alphanumeric symbols.


### For more information

please check out here: 

[https://hub.docker.com/r/microsoft/mssql-server-linux/](https://hub.docker.com/r/microsoft/mssql-server-linux/)

[https://github.com/Microsoft/mssql-docker](https://github.com/Microsoft/mssql-docker)