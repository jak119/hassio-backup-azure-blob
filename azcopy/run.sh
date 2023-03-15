#!/command/with-contenv bashio
# shellcheck disable=all
SAS="$(bashio::config 'sas_token')"

params=()
if [[ $(bashio::config.true 'mirror') ]]; then
    bashio::log.warning "Mirror mode is enabled"
    bashio::log.warning "This will cause Azcopy to DELETE blobs in the destination that are not present in /backup"
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
