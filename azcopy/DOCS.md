# Backup to Azure Blob Documentation

## Installation

Follow these steps to get the add-on installed on your system:

1. Navigate in your Home Assistant frontend to **Supervisor** -> **Add-on Store**.
1. Click the **three dots** in the top right -> **Repositories** -> Add `https://github.com/jak119/hassio-backup-azure-blob`
1. Find the "Backup to Azure Blob" add-on and click it
1. Click on the "INSTALL" button

## Configuration

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
