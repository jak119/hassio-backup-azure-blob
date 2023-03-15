#!/command/with-contenv bashio

CONTAINER="$(bashio::config 'containername')"

bashio::log.info "Found these backups:"
bashio::log.info "$(ls /backup/)"

params=()
if bashio::config.has_value "timeout_value"
then
    bashio::log.info "Timeout value of $(bashio::config 'timeout_value') is specified"
    params+=(--timeout "$(bashio::config 'timeout_value')")
fi

bashio::log.info "=== Starting copy ==="
# az storage blob upload-batch --connection-string "$(bashio::config 'connectionstring')" -d $CONTAINER -s /backup/ --no-progress $params
az storage blob upload-batch --connection-string "$(bashio::config 'connectionstring')" -d $CONTAINER -s /backup/ --no-progress

bashio::log.info "=== Finished copy ==="
bashio::exit.ok
