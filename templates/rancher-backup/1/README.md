# Rancher Backup

## Info:

This template deploy one container that manage backup aspect in your Rancher environment.
For the moment, this template permit to perform the following actions:
- Dump automatically all databases supported before start the remote backup:
  - PostgreSQL
  - MySQL
  - MariaDB
  - MongoDB
  - Elasticsearch
 - Dump automatically all rancher stacks settings (docker-compose.yml and rancher-compose.yml) before start the remote backup
 - Perform the remote backup of all `/backup` with duplicity (you can mount your shares storages on `/backup` to backup them)

 To manage your backup policy, you can use the following environment variables:
 - `CRON_SCHEDULE`: when you should start backup (incremental if full is not needed). For example, to start backup each day set `0 0 0 * * *`
 - `BACKEND`: this is the target URL to externalize the backup. For example, to use FTP as external backup set `ftp://login@my-ftp.com` and add environment variable `FTP_PASSWORD`. For Amazon S3, set `s3://host[:port]/bucket_name[/prefix]`. Read the ducplicity man for [all supported backend](http://duplicity.nongnu.org/duplicity.1.html#sect7). There are no default value.
 - `TARGET_PATH`: The path were store backup on local and remote. The default value is `/backup`.
 - `BK_FULL_FREQ`: The frequency when you should make a full backup. For example, if you should make a full backup each 7 days, set `7D`. The default value is `7D`.
 - `BK_KEEP_FULL`: How many full backup you should to keep. For example, to keep 3 full backup set `3`. The default value is `3`.
 - `BK_KEEP_FULL_CHAIN`: The number of intermediate incremental backup you should keep with the full backup. For example, if you should keep only the incremental backup after the last full backup set `1`. The default value is set to `1`.
 - `VOLUME_SIZE`: The volume size to store the backup (in MB). The default value is `25`.
 - `DISABLE_DUMP`: Permit to disable the databases dump before launch the Backup
 - `DISABLE_DUMP_RANCHER`: Permit to disable the Rancher settings dump  before launch the Backup.

> Note: you can read [the duplicity documentation](http://duplicity.nongnu.org/duplicity.1.html) about backup policy


The currents backends supported by duplicity are FTP, Azure, B2, Cloud Files, Dropbox, FISH, Google Docs, Google Cloud Storage, HSI, Hubbic, Mega cloud storage, OneDrive backend, Par2 Wrapper Backend, S3 storage, Swift and MediaFire

## Deployment:
* Select Rancher Backup from the community catalog.
* Click deploy.

## Usage
* Just start the service and read the output or `/var/log/backup/backup.log` to check all work fine you expected.

### Specifics need
If you have a very specifics need to perform a dump before backup, you can create your own setting (read the README), and mount it to `/app/config`.

### General need
If you need to perform a dump before backup on general software that is not yet supported, you can :
- Contribute -> go to https://github.com/disaster37/rancher-backup
- Open enhance -> go to https://github.com/disaster37/rancher-backup/issues

## Issues / Enhance
Please open directly issues or enhance on https://github.com/disaster37/rancher-backup/issues
