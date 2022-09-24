#!/usr/bin/env bashio

CONFIG_PATH=/data/options.json
CONTAINER="$(bashio::config 'containername')"

bashio::log "Found these backups:"
ls /backup/

params=()
if bashio::config.has_value "timeout_value"
then
    bashio::log "Timeout value of $(bashio::config 'timeout_value') is specified"
    params+=(--timeout "$(bashio::config 'timeout_value')")
fi

bashio::log "=== Starting copy ==="
bashio::color.blue
# az storage blob upload-batch --connection-string "$(bashio::config 'connectionstring')" -d $CONTAINER -s /backup/ --no-progress $params
az storage blob upload-batch --connection-string "$(bashio::config 'connectionstring')" -d $CONTAINER -s /backup/ --no-progress

bashio::color.black
bashio::log "=== Finished copy ==="
bashio::exit.ok
