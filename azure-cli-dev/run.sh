#!/command/with-contenv bashio

CONTAINER="$(bashio::config 'containername')"
CONNECTION_STRING="$(bashio::config 'connectionstring')"

bashio::log.info "Found these backups:"
bashio::log.info "$(ls /backup/)"

bashio::log.info "Starting Python script"

python backup.py

bashio::exit.ok
