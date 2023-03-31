# Backup to Azure Blob

## Deprecation Notice

This add on is deprecated and no longer maintained. Image builds on GitHub Actions fail due to the sheer size of this image. I strongly suggest you take a look at adopting the [Azcopy add-on in this same repository](https://my.home-assistant.io/redirect/supervisor_addon/?addon=b03c22bd_azcopy&repository_url=https%3A%2F%2Fgithub.com%2Fjak119%2Fhassio-backup-azure-blob).

[![Open your Home Assistant instance and show the dashboard of a Supervisor add-on.](https://my.home-assistant.io/badges/supervisor_addon.svg)](https://my.home-assistant.io/redirect/supervisor_addon/?addon=b03c22bd_azcopy)

If you still require this add-on you can install it and it will build (slowly) on your Home Assistant instance. Once you click install please give it an ample amount of time (in my testing ~45 minutes) to build before it'll appear in your add-ons.

<details><summary>Original add-on description</summary>

A Hassio Add-on that's designed to start up and copy Hassio snapshots to an Azure Storage Account. This container can be called periodically via Home Assistant Automation and / or used in combination with [Hass Auto Backup](https://github.com/jcwillox/hass-auto-backup). See [docs.md](DOCS.md) for more info on installing and configuring.

## Prerequisites

- Azure Storage Account
  - Including [Connection String](https://docs.microsoft.com/en-us/azure/storage/common/storage-account-keys-manage?tabs=azure-portal#view-account-access-keys)
  - And existing container

## Inspired by

- [rrostt/hassio-backup-s3](https://github.com/rrostt/hassio-backup-s3)
- [matsuu/docker-azure-cli](https://github.com/matsuu/docker-azure-cli)
</details>