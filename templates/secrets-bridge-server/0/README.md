## Secrets Bridge Server (Experimental)
---
###Status: Experimental POC (Read: Do NOT use for production) 
Only works with Hashicorp Vault server in dev mode currently.

---
#### Description: 
  This is the server side component for the Vault Secrets bridge with Rancher. This service should *NOT* be deployed in the same environment as user applications. It will have access to Vault, and compromising it will give the person access to *ALL* secrets available in that environment. It should instead be run in an environment reserved for the team operating Rancher.
  
  The reason this uses a temporary Cubbyhole token to start the service is that ENV variables do show up in the Rancher API and Docker inspect commands.
  
#### Pre-reqs:

A Vault server in Dev mode.

Create Vault Policies and Roles for at least the Issuing token. 
Something like:

```
  vault policy-write grantor-Default ./policies/grantor-Default
  vault policy-write test1 ./policies/test1
  vault policy-write test2 ./policies/test2
```


```
curl -s -X POST -H "X-Vault-Token: ${VAULT_TOKEN}" -d '{"allowed_policies": "default,grantor,test1,test2"}' http://vault/v1/auth/token/roles/grantor-Default
```

#### Configure and Launch:
 1. Create a token to be used to issue new tokens in the environment. As part of the "meta" on the token add a field called `configPath` and set that equal to a path in the secrets folder in Vault. (like `/secrets/secrets-bridge/Default`)


  ```
curl -s -X POST -H "X-Vault-Token: $ROOT_TOKEN" ${VAULT_URL}/v1/auth/token/create/grantor-Default -d '{"policies": ["default", "grantor", "test1", "test2"], "ttl": "72h", "meta": {"configPath": "secret/secrets-bridge/Default"}}' | jq -r '.auth.client_token'
  ```

 
 2. Create a temporary token with (2) uses.

  ```
  curl -s -H "X-Vault-Token: $ROOT_TOKEN" ${VAULT_URL}/v1/auth/token/create -d '{"policies": ["default"], "ttl": "15m", "num_uses": 2}'|jq -r '.auth.client_token'
  ```
 
 3. Use the temporary token to put the issuing token into the Vault cubbyhole.

    ```
 curl -X POST -H "X-Vault-Token: ${TEMP_TOKEN}" ${VAULT_URL}/v1/cubbyhole/Default -d "{\"permKey\": \"${PERM_TOKEN}\"}"
    ```
 
 4. Create Cattle API keys for the environment this server will be handling. (Would recommend 1 server per environment)
 
 5. Launch this app with all of the configs.
 

