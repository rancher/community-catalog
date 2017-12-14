## Etcd v2.3.7 Persistent

### Upgrade WARNING

Automated upgrading to this version is only supported from `2.3.7-build.11`. If you are on a previous version, please upgrade to `2.3.7-build.11` before upgrading to this version. It is recommended you perform a manual backup before continuing.

### Backup Configuration

Backups are enabled/disabled via the `Enable Backups` radio buttons.

The backup period durations must be a sequence of decimal numbers, each with optional fraction and a unit suffix, such as `300ms`, `1.5h` or `2h45m`. Valid time units are `ns`, `us` or `µs`, `ms`, `s`, `m` and `h`.

The `Backup Creation Period` duration indicates at what rate backups should be created. It is not recommended to create backups more often than `30s`.

The `Backup Retention Period` duration indicates at what rate historical backups should be deleted. Backups outside of the retention period are expired after the next successful backup.

The maximum number of backups stored on disk at any given moment follows the equation `ceiling(retention period / creation period)`. For example, `5m` creation period with `4h` retention period would store at most `ceiling(4h / 5m)` backups or `48` backups. A conservative estimate for backup size is `50MB`, so the attached network storage should have at least `2.4GB` free space. Backup sizes will vary depending on usage.

If backups are disabled, the values for `Backup Creation Period` and `Backup Retention Period` are ignored.

### Disaster Recovery

See [this wiki](https://github.com/rancher/rancher/wiki/Kubernetes-Management#disaster-recovery) for instructions.

### Restoring Backups

See [this wiki](https://github.com/rancher/rancher/wiki/Kubernetes-Management#restoring-backups) for instructions.
