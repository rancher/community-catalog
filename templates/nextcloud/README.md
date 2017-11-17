# NextCloud

Enterprise File Sync and Share

## Configuration

When you start Nextcloud for the first time you will see the [Installation Wizard](https://docs.nextcloud.com/server/12/admin_manual/installation/installation_wizard.html). 

1.) Point your Web browser to your Nextcloud Installation and enter your [Username / Password](https://docs.nextcloud.com/server/12/admin_manual/installation/installation_wizard.html#quick-start).   

2.) We persist the [Data Directory Location](https://docs.nextcloud.com/server/12/admin_manual/installation/installation_wizard.html#data-directory-location) from `/var/www/html/data` to a Sidekick Container.  *(If you don't change the location there is nothing else to do. In case you want to use another directory you have to update the volumes entry for the `nextcloud-data` service in `docker-compose.yml`.)*

3.) The last step is to update the [Database Settings](https://docs.nextcloud.com/server/12/admin_manual/installation/installation_wizard.html#database-choice) and switch from SQLite to MariaDB for better performance. 

- Database: `YOUR-DATABASE` (default: `nextcloud`)
- MySQL Username: `YOUR-USER` (default: `nextcloud`)
- MySQL Password: `YOUR-PASSWORD`
- MySQL Hostname: `mariadb` (**Important:** Use `mariadb` instead of `localhost`)

Read more in the official [Nextcloud Documentation](https://docs.nextcloud.com/).


