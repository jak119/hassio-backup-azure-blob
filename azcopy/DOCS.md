# Backup to Azure Blob Documentation

This configuration will require two items outlined below

```yaml
sas_token: >-
  https://[account].blob.core.windows.net/[container]/[path/to/virtual/dir]?[SAS]
delete: false
```

### Option: `sas_token` (required)

This is your [SAS token](https://learn.microsoft.com/en-us/azure/cognitive-services/translator/document-translation/how-to-guides/create-sas-tokens?tabs=Containers) with read, add, create, write, delete, and list permissions.

### Option: `delete` (optional)

Set this option to true if you want to use the `--delete-destination` parameter on `azcopy sync`. This will cause Azure to have an exact replica of the backups on your Home Assistant instance.
