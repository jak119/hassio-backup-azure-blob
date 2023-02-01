# Backup to Azure Blob with Restic Documentation

## Installation

Follow these steps to get the add-on installed on your system:

1. Navigate in your Home Assistant frontend to **Supervisor** -> **Add-on Store**.
1. Click the **three dots** in the top right -> **Repositories** -> Add `https://github.com/jak119/hassio-backup-azure-blob`
1. Find the "Backup to Azure Blob with Restic" add-on and click it
1. Click on the "INSTALL" button

## Configuration

This configuration will require items outlined below

| Config Value   | Description                                                                                                                      | Link for info                                                                                                                |
| -------------- | -------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| storageaccount | Name of your storage account                                                                                                     | https://docs.microsoft.com/en-us/azure/storage/common/storage-account-create                                                 |
| key            | Storage account key                                                                                                              | https://docs.microsoft.com/en-us/azure/storage/common/storage-account-keys-manage?tabs=azure-portal#view-account-access-keys |
| containername  | Name of the container to use                                                                                                     |                                                                                                                              |
| folder         | The name of a folder to use within your container                                                                                |                                                                                                                              |
| repopassword   | A password to encrypt your backups with, this must not appear in the [Pwned Password list](https://haveibeenpwned.com/Passwords) |                                                                                                                              |
| days_to_keep   | How many days of snapshots to keep                                                                                               |                                                                                                                              |
