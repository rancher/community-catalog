# Let's Encrypt Certificate Manager
### About
The Let's Encrypt Certificate Manager obtains a free (SAN) SSL Certificate from the [Let's Encrypt CA](https://letsencrypt.org/) and adds it to Rancher's certificate store. Once the certificate is created it is scheduled for auto-renewal 14-days before expiration. The renewed certificate is propagated to all applicable load balancer services.
     
### Usage
 1. Accept the terms of service.
 2. Select the API version to use. The Sandbox API should be used for testing purposes.
 3. Fill in your email address.
 4. Enter the name used for storing the certificate in Rancher and volumes. Any existing certificate by that name will be updated.
 5. Enter one or more domain names. The first domain will be used as the Common Name property of the certificate.
 6. Optionally, specifiy the host path or volume name in which to store certificate and private key ([Usage](https://github.com/janeczku/rancher-letsencrypt#accessing-certificates-and-private-keys-from-other-services)).
 7. Fill in the required credentials for the provider. AWS Route 53 requires IAM permissions as specified [here](https://github.com/janeczku/rancher-letsencrypt#aws-route-53).

If you want the certificate to be automatically renewed, leave the service running. Otherwise you may remove the service once the certificate has appeared in Rancher's certificate store.
    
### Suggestions & issue reports
Please submit suggestions or any issues you find to the [rancher-letsencrypt](https://github.com/janeczku/rancher-letsencrypt) GitHub repo.