#!/command/with-contenv bashio

export CONTAINER="$(bashio::config 'containername')"
export CONNECTION_STRING="$(bashio::config 'connectionstring')"

bashio::log.info "Found these backups:"
bashio::log.info "$(ls /backup/)"

bashio::log.info "Starting Python script"

python3 backup.py

bashio::exit.ok
