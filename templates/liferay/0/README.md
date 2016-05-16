# Liferay Portal Community Edition 6.2

Installs Liferay Portal, an open source enterprise portal. Uses MySQL as database.

### First Start

Use the following credentials to log in as the default administrative user:
* user name: **test@liferay.com**
* password: **test**

If you choose to run the Setup Wizard at first start, you can create a different
administrative user.

### Watch the Logs

Open a terminal via `Execute Shell` on the Liferay container, then use `tail`
on the log files in `/opt/liferay/tomcat/logs` and `/opt/liferay/logs`, e.g.

```bash
tail -f /opt/liferay/tomcat/logs/catalina.2016-04-13.log
tail -f /opt/liferay/logs/liferay.2016-04-13.log
```