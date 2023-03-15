#!/command/with-contenv bashio
# shellcheck disable=all
export AZCOPY_JOB_PLAN_LOCATION=/data

SAS="$(bashio::config 'sas_token')"

params=()
if [[ $(bashio::config 'overwrite') == false ]]; then
    params+=(--overwrite=false)
fi

params+=(--output-level quiet)
params+=(--put-md5)

# bashio::log.info "Found these backups:"
# bashio::log.info "$(ls /backup/)"

bashio::log.info "$(azcopy --version)"

set -x
azcopy copy "/backup/*" "$SAS" "${params[@]}"
