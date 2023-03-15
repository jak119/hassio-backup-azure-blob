#!/command/with-contenv bashio
# shellcheck disable=all
SAS="$(bashio::config 'sas_token')"

params=()
if [[ $(bashio::config.true 'mirror') ]]; then
    bashio::config.suggest.false 'mirror' 'This will cause backups to be deleted from Azure'

    params+=(--mirror-mode=true)
fi

params+=(--output-level quiet)
params+=(--put-md5)

# bashio::log.info "Found these backups:"
# bashio::log.info "$(ls /backup/)"

bashio::log.info "$(azcopy --version)"

bashio::log.info "Starting Azcopy"
set -x
azcopy sync "/backup/*" "$SAS" "${params[@]}"
