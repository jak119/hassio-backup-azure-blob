# Backup to Azure Blob

A Hassio Add-on that's designed to start up and copy Hassio snapshots to an Azure Storage Account. This container can be called periodically via Home Assistant Automation. See [docs.md](DOCS.md) for more info on installing and configuring.

## Prerequisites

- Azure Storage Account
  - An existing container
  - SAS Key for a container with read, add, create, write, delete, and list permissions

## Inspired by

- [rrostt/hassio-backup-s3](https://github.com/rrostt/hassio-backup-s3)
- [PeterDaveHello/docker-azcopy](https://github.com/PeterDaveHello/docker-azcopy)
