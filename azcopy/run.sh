#!/command/with-contenv bashio
SAS="$(bashio::config 'sas_token')"

params=()
if $(bashio::config.true 'delete'); then
    bashio::config.suggest.false 'delete' 'This will cause backups to be deleted from Azure'

    params+=(--delete-destination=true)
fi

params+=(--output-level essential)
params+=(--put-md5)

# bashio::log.info "Found these backups:"
# bashio::log.info "$(ls /backup/)"

bashio::log.info "$(azcopy --version)"

bashio::log.info "Starting Azcopy at $(date +"%Y-%m-%dT%H:%M:%S%z")"
azcopy sync "/backup" "$SAS" "${params[@]}"

if [ $? -eq 0 ]; then
    bashio::log.info "Azcopy successfully completed at $(date +"%Y-%m-%dT%H:%M:%S%z")"
    bashio::exit.ok
else
    bashio::exit.nok "There was an error with Azcopy"
fi
