# Traefik load balancer

### Info:

 This template deploys traefik active load balancer on top of Rancher. It would be deployed in hosts with label **traefik_lb=true**.

### Config:

- Replicas: Number of pods to deploy. It should be the same of hosts whith traefik_lb=true
- Kubernetes Namespace = Kubernetes namespace to deploy de repservers lication controller
- Http port = 80  # Port exposed to get access to the published services.
- Https port = 443  # Port exposed to get access to the published services.
- Admin port = 8000  # Port exposed to get admin access to the traefik service.


### Service configuration:

You have to create Ingress objects in order to get included in traefik dynamic config. Example:

```
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: foo
  namespace: default
spec:
  rules:
  - host: foo.bar.com
    http:
      paths:
      - backend:
          serviceName: foo
          servicePort: 8080
```

### Usage:

- Select Traefik from catalog.
- Review configuration options.
- Click deploy.
- Services with Ingress will be accessed throught hosts whith traefik_lb=true
