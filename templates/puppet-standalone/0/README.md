# Puppet 4 .x (standalone)

### Info

A Rancher Cattle Catalog entry for deploying a Puppet 4.x Open Source-only master. The Catalog entry is suitable for development
and testing of Puppet codebases.

### Usage

Launch the Catalog entry. If no Puppet control repo is specified in the Rancher console no attempt will be made to sync
a Puppet control repo. Catalog compiles will be against a default Puppet code base in the 'production' environment.

If a Puppet control repo is specified during launch of the Catalog entry r10k will run a full branch sync of the control
repo during Puppet container provisioning. A manual resync post-launch can be performed by restarting the Puppet container
however the full cycle of container restart, r10k sync, and load-balancer registration + availability is on the order of seconds
to minutes so this is of limited use for rapid iteration of Puppte codebases. This is a known issue (see TODO).

The puppetserver process in the Puppet container is configured for autosigning of Puppet agent certificates('*').

### Notes

The Puppet master configuration in this Catalog entry is, by design, minimal in functionality:

* currently no management consoles
* currently not PuppetDB integrated
* lacking in any other community add-ons/bells-and-whistles

See the TODO.

### Development / Bug Reports / Feedback

The Puppet 4.x (standalone) Catalog entry resides in a repo alongside other Rancher community Catalog entries at:

* [https://github.com/rancher/community-catalog](https://github.com/rancher/community-catalog)

however development happens via the following repo:

* [https://github.com/nrvale0/rancher-cattle-puppet](https://github.com/nrvale0/rancher-cattle-puppet)

For direct access to the author / maintainer it probably makes to file bug reports and file pull requests at the latter repo.

### TODO
  * add ability to configure r10k to authenticate to private control repos using an SSH key
  * provide a method for manual resyncing of control repos using r10k which does not involve restarting the Puppet container
  * provide user a way to specify periodicity of automatic r10k syncs of the control repo
  * integrate one of the Open Source consoles for viewing Puppet Reports, Facts, and other misc node information
  * allow the user to pass custom autosinging globs

### Author

Nathan Valentine - &lt;[nathan@rancher.com](mailto:nathan@rancher.com) | [nrvale0@gmail.com](mailto:nrvale0@gmail.com)&gt;  
[https://www.rancher.com](https://www.rancher.com)  
[https://nrvale0.github.io](https://nrvale0.github.io)  
twitter: [@nrvale0](https://twitter.com/nrvale0)  
