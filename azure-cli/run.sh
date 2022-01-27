#!/usr/bin/env bashio

CONFIG_PATH=/data/options.json
CONTAINER="$(bashio::config 'containername')"

bashio::log "Found these backups:"
ls /backup/

params=()
if bashio::config.has_value "timeout_value"
then
    bashio::log "Timeout is specified"
    params+=(--timeout $(bashio::config 'timeout_value'))
fi

bashio::log "=== Starting copy ==="
bashio::color.blue
az storage blob upload-batch --connection-string "$(bashio::config 'connectionstring')" -d $CONTAINER -s /backup/ --no-progress $params

bashio::color.black
bashio::log "=== Finished copy ==="
bashio::exit.ok
