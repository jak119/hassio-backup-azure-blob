#!/command/with-contenv bashio
# shellcheck disable=all
SAS="$(bashio::config 'sas_token')"

params=()
if $(bashio::config.true 'delete-destination'); then
    bashio::config.suggest.false 'delete-destination' 'This will cause backups to be deleted from Azure'

    params+=(--delete-destination=true)
fi

params+=(--output-level quiet)
params+=(--put-md5)

# bashio::log.info "Found these backups:"
# bashio::log.info "$(ls /backup/)"

bashio::log.info "$(azcopy --version)"

bashio::log.info "Starting Azcopy"
set -x
azcopy sync "/backup/*" "$SAS" "${params[@]}"

if [ $? -eq 0 ]; then
    bashio::log.green "Azcopy successfully completed"
    bashio::exit.ok
else
    bashio::exit.nok "There was an error with Azcopy"
fi
