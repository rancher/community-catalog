# Janitor

### Topology

A Janitor instance will be started on every host that does not match the
scheduling rule (default is `janitor.exclude=true`).

### Operation

This will run a task daily (by default) that will delete any unused
image, and any orphaned volume.  The rancher container images are excluded
from the list of images to clean up, and you can add your own containers to
the exclude list if you wish.  It will also remove any stopped containers
that are taking up space; note that this may not be what you want if you
are using stopped containers to hold volumes!  If this is the case, use the
Keep List below.

This cleanup will help to prevent the /var/lib/docker filesystem from filling
up with old and unused container images, which is an issue on lighter-weight
Docker hosts.

### Keep list

You can specify match patterns for unused Images, and stopped Containers,
which should be excluded from the cleanup.

The match patterns are comma-separated Left Anchored Bash Shell wildcard
patterns.  For example, an image called **foo/bar:latest** will match:

* foo/
* foo/bar
* \*:latest
* \*/bar
* \*:\*
* fo

However it will not match

* foo/baz
* bar:latest
* foo/\*:v1

By default, nothing will be matched.  If you want to match everything,
then use a pattern **\*:\***

The self-descriptive values '\*\*None\*\*' and '\*\*All\*\*' can also be used.

### Warning

If you are using 'run-once' sidekick containers that mount a volume, then
these containers may be removed by Janitor!  Ensure that the list of
Containers to keep matches these containers -- setting it to
'\*:\*' will keep all containers, which is in general the best solution.
