# Backup to Azure Blob Documentation

This configuration requires either a SAS token or a ServicePrincipal authorization. The configuration items are outlined below

```yaml
# Mandatory
auth_type: "sp" # supported values: `sp` or `sas`
storage_url: "https://[account].blob.core.windows.net/[container]/[path/to/virtual/dir]"
# if auth_type is `sas`, include the SAS token in the URL
delete: "false"
# if auth_type is `sp`, token_id, client_id and client_secret are required
tenant_id: "[tenant id]"
client_id: "[service principal client id]"
client_secret: "[client secret]"
```

### Option: `auth_token` (required)

Possible values: `sas` or `sp`

`sas`: Use SAS Token for storage authentication
`sp` : Use service principal authentication

### Option: `tenant_id` (required if `auth_type` is `sp`)

Tenant ID for service principal (`sp`) type auth.

### Option: `client_id` (required if `auth_type` is `sp`)

Service principal ID for service principal (`sp`) type auth.

### Option: `client_secret` (required if `auth_type` is `sp`)

Service principal secret for service principal (`sp`) type auth.

### Option: `delete` (optional)

Set this option to true if you want to use the `--delete-destination` parameter on `azcopy sync`. This will cause Azure to have an exact replica of the backups on your Home Assistant instance.
