## Secrets Bridge Server (Beta)
---
#### Upgrade NOTICE

When upgrading this service keep in mind that if you use a new issuing token, tokens issued by the previous version will expire. This means running apps will no longer be able to access Vault using those tokens. If you need to keep those tokens fresh, then reuse the original PERM_TOKEN.

#### Description: 
  This is the server side component for the Vault Secrets bridge with Rancher. This service should *NOT* be deployed in the same environment as user applications. It will have access to Vault, and compromising it will give the person access to *ALL* secrets available in that environment. It should instead be run in an environment reserved for the team operating Rancher.
  
  The reason this uses a temporary Cubbyhole token to start the service is that ENV variables do show up in the Rancher API and Docker inspect commands. That said, if this service fails, the issuing token will expire and all app tokens will also expire.
  
#### Setup

See [setup guide](https://github.com/rancher/secrets-bridge/blob/master/docs/setup.md)
  
