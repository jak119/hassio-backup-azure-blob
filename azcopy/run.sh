#!/command/with-contenv bashio
# shellcheck disable=all
SAS="$(bashio::config 'sas_token')"

params=()
if [[ $(bashio::config 'overwrite') == false ]]; then
    params+=(--overwrite=false)
fi

bashio::log.info "Found these backups:"
bashio::log.info "$(ls /backup/)"

bashio::log.info "Azcopy version"
bashio::log.info "$(azcopy --version)"

azcopy copy /backup/* "$SAS" "${params[@]}"
