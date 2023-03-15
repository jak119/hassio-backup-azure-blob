#!/command/with-contenv bashio
# shellcheck disable=all
export AZCOPY_JOB_PLAN_LOCATION=/data

SAS="$(bashio::config 'sas_token')"

params=()
if [[ $(bashio::config.true 'mirror') == true ]]; then
    bashio::log.warning "Mirror mode is enabled"
    bashio::log.warning "This will cause Azcopy to DELETE blobs in the destination that are not present in /backup"
    params+=(--mirror-mode=true)
fi

params+=(--output-level quiet)
params+=(--put-md5)

# bashio::log.info "Found these backups:"
# bashio::log.info "$(ls /backup/)"

bashio::log.info "$(azcopy --version)"

set -x
bashio::log.info "Starting Azcopy"
azcopy sync "/backup/*" "$SAS" "${params[@]}"
