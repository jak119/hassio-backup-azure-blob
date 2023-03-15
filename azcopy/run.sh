#!/command/with-contenv bashio
# shellcheck disable=all
CONTAINER="$(bashio::config 'containername')"

bashio::log.info "Found these backups:"
bashio::log.info "$(ls /backup/)"

bashio::log azcopy --version

bashio::exit.ok
