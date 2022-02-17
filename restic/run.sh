#!/usr/bin/env bashio

# Set variables
export AZURE_ACCOUNT_NAME="$(bashio::config 'storageaccount')"
export AZURE_ACCOUNT_KEY="$(bashio::config 'key')"
CONTAINER="$(bashio::config 'containername')"
FOLDER="$(bashio::config 'folder')"

# Check for a Restic repo, initialize if it doesn't exist

# Then backup

# Cleanup old snapshots
