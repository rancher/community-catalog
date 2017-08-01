RabbitMQ 3.6 with easy Rancher clustering
===
Provides RabbitMQ image that can scale to a cluster.

The following environment variables are passed to confd in order to set up RabbitMQ's configuration file:

* Partition handling: RabbitMQ's cluster handling setting: default set to autoheal
* Erlang cookie: cookie to allow nodes communication: default set to defaultcookiepleasechange
* Net ticktime: adjusts the frequency of both tick messages and detection of failures: default set to 60
* Confd args: additional confd args along with default --backend rancher --prefix /2015-07-25: default set to --interval 5

*Note*: You can pass an alternate `confd` configuration via the `ALTERNATE_CONF` environment variable.
