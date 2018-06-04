# Weave Cloud Agents

Weave Cloud is a add-on to Kubernetes which provides Continuous Delivery, along with hosted Prometheus Monitoring and a visual dashboard for exploring & debugging microservices.

This package contains the agents which connect your cluster to Weave Cloud.

_To learn more and sign up please visit [Weaveworks website](https://weave.works)._

You will need a service token which you can get from [cloud.weave.works](https://cloud.weave.works/).

## Technical Information

This stack installs a Kubernetes job that in turns installs the latest version of all the neccessary components.

To view the pods installed, try `kubectl get pods -n kube-system -l weave-cloud-component`.

## If you need to Uninstall...

If you would like to uninstall this stack, you will need to do it using Rancher UI or CLI first, and then run the following command:

```
kubectl detele -n kube-system -f "https://cloud.weave.works/k8s.yaml?t=${WEAVE_CLOUD_SERVICE_TOKEN}"
```
