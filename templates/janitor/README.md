# Janitor

### Topology

A Janitor instance will be started on every host that does not match the
scheduling rule (default is `janitor.exclude=true`).

### Operation

This will run a task daily (by default) that will delete any unused
image, and any orphaned volume.  The rancher container images are excluded
from the list of images to clean up.

This will halp to prevent the /var/lib/docker filesystem from filling up
with old and unused container images.

