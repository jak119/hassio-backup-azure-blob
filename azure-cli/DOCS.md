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
connectionstring: >-
  DefaultEndpointsProtocol=https;AccountName=sample;AccountKey=someKey==;EndpointSuffix=core.windows.net
containername: ha-backup
```

### Option: `connectionstring` (required)

This is your [Connection String](https://docs.microsoft.com/en-us/azure/storage/common/storage-account-keys-manage?tabs=azure-portal#view-account-access-keys) from your Storage Account.

### Option: `containername` (required)

This is the name of the container you'd like backups to be uploaded to.
