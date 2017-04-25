# Mesos-dns (Experimental)

### Info

Add mesos-dns component to your mesos orchestrator, to be able that docker 

### Usage

Mesos-dns will be listening at link_local_ip and will forward dns queries to rancherDNS.

To deploy marathon tasks, you need to set network=HOST and set dns=link_local_ip

Marathon json template example
```
{
  "id": "NAME",
  "cmd": null,
  "cpus": 1,
  "mem": 128,
  "disk": 0,
  "instances": 1,
  "container": {
    "type": "DOCKER",
    "volumes": [],
    "docker": {
      "image": “DOCKER_IMAGE",
      "network": "HOST",
      "privileged": false,
      "parameters": [
        {
          "key": "dns",
          "value": "169.254.169.251"
        }
      ],
      "forcePullImage": false
    }
  },
  "portDefinitions": [
    {
      "port": 10000,
      "protocol": "tcp",
      "labels": {}
    }
  ]
}
```