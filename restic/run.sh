#!/usr/bin/env bashio

# Set variables
export AZURE_ACCOUNT_NAME="$(bashio::config 'storageaccount')"
export AZURE_ACCOUNT_KEY="$(bashio::config 'key')"
CONTAINER="$(bashio::config 'containername')"
FOLDER="$(bashio::config 'folder')"
RESTIC_REPOSITORY="azure:"${CONTAINER}":/"${FOLDER}

# Function Definitions

function initializeRepository() {
    # Inspired by https://github.com/PHLAK/restic-init/
    if restic -p ./password.txt --no-cache --repo ${RESTIC_REPOSITORY} snapshots &> /dev/null; then
        echo "Respository already intialized at ${RESTIC_REPOSITORY}"
        return 0
    fi

    echo -n "Initializaing repository at ${RESTIC_REPOSITORY} ... "
    restic -p ./password.txt init --repo ${RESTIC_REPOSITORY} > /dev/null
    echo "DONE"
}

function runBackup() {
    restic -p ./password.txt --repo ${RESTIC_REPOSITORY} backup /backup/
}

function pruneOldBackups() {
    restic -p ./password.txt --repo ${RESTIC_REPOSITORY} --keep-daily "$(bashio::config 'days_to_keep')"
}

# Create a password file
echo "$(bashio::config 'repopassword')" >> ./password.txt

# Check for a Restic repo, initialize if it doesn't exist
initializeRepository

# Then backup
runBackup

# Cleanup old snapshots
pruneOldBackups
