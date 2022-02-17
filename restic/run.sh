#!/usr/bin/env bashio

# Set variables
export AZURE_ACCOUNT_NAME="$(bashio::config 'storageaccount')"
export AZURE_ACCOUNT_KEY="$(bashio::config 'key')"
CONTAINER="$(bashio::config 'containername')"
FOLDER="$(bashio::config 'folder')"
RESTIC_REPOSITORY="azure:${CONTAINER}:/${FOLDER}"

# Function Definitions

function initializeRepository() {
    # Inspired by https://github.com/PHLAK/restic-init/
    if restic -p ./password.txt --no-cache --repo ${RESTIC_REPOSITORY} snapshots &> /dev/null; then
        bashio::log.green "Respository already intialized at ${RESTIC_REPOSITORY}"
        return 0
    fi

    bashio::log "Checking repo password"
    bashio::pwned.is_safe_password "$(bashio::config 'repopassword')"

    bashio::log "Initializaing repository at ${RESTIC_REPOSITORY} ... "
    restic -p ./password.txt init --repo ${RESTIC_REPOSITORY} > /dev/null
    bashio::log.green "Initialized repo"
}

function runBackup() {
    bashio::log "Starting backup"
    restic -p ./password.txt --repo ${RESTIC_REPOSITORY} backup /backup/
    bashio::log.green "Backup completed"
}

function pruneOldBackups() {
    bashio::log "Pruning old backups"
    restic -p ./password.txt --repo ${RESTIC_REPOSITORY} forget --keep-daily "$(bashio::config 'days_to_keep')"
    bashio::log.green "Pruning completed"
}

# Create a password file
echo "$(bashio::config 'repopassword')" >> ./password.txt

# Check for a Restic repo, initialize if it doesn't exist
initializeRepository

# Then backup
runBackup

# Cleanup old snapshots
pruneOldBackups

# Exit the script nicely
bashio::exit.ok
