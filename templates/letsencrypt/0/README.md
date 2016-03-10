# Let's Encrypt Certificate Manager
    
### About
    
The Let's Encrypt Certificate Manager obtains a free (SAN) SSL Certificate from the [Let's Encrypt CA](https://letsencrypt.org/) and adds it to Rancher's certificate store. Once the certificate is created it is scheduled for auto-renewal 14-days before expiration. The renewed certificate is propagated to all applicable load balancer services.
     
### Usage
    
 1. Accept the terms of service.
 2. Select the API version to use. The Sandbox API should be used for testing purposes.
 3. Fill in your email address.
 4. Enter one or more domain names in the 'Domain Names' field.
 5. Select the DNS provider which manages the DNS zone(s) for all entered domains.
 5. Fill in the required credentials for the chosen DNS provider.
 6. Click 'Launch'.
     

If you want your certificate to be automatically renewed leave the service running. Otherwise you may remove the service once the certificate has appeared in Rancher's certificate store.
    
### Suggestions & issue reports

Please submit suggestions or any issues you find to the [rancher-letsencrypt](https://github.com/janeczku/rancher-letsencrypt) GitHub repo.