# Backup to Azure Blob

A Hassio Add-on that's designed to start up and copy Hassio snapshots to an Azure Storage Account. This container can be called periodically via Home Assistant Automation and / or used in combination with [Hass Auto Backup](https://github.com/jcwillox/hass-auto-backup). See [docs.md](DOCS.md) for more info on installing and configuring.

## Prerequisites

- Azure Storage Account
  - Including [Connection String](https://docs.microsoft.com/en-us/azure/storage/common/storage-account-keys-manage?tabs=azure-portal#view-account-access-keys)
  - And existing container

## Inspired by

- [rrostt/hassio-backup-s3](https://github.com/rrostt/hassio-backup-s3)
- [matsuu/docker-azure-cli](https://github.com/matsuu/docker-azure-cli)
