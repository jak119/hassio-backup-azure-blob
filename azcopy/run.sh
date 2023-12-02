#!/command/with-contenv bashio

auth_type="$(bashio::config 'auth_type')"
storage_url="$(bashio::config 'storage_url')"
tenant_id="$(bashio::config 'tenant_id')"
client_id="$(bashio::config 'client_id')"
client_secret="$(bashio::config 'client_secret')"

params=()
if $(bashio::config.true 'delete'); then
    bashio::config.suggest.false 'delete' 'This will cause backups to be deleted from Azure'

    params+=(--delete-destination=true)
fi

params+=(--output-level essential)
params+=(--put-md5)

case $auth_type in
  sas)
    bashio::log.info "Using SAS token";;

  sp)
    [[ -z $tenant_id || -z $client_id || -z $client_secret ]] && bashio::exit.nok "tenant_id, client_id and client_secret are required for auth_type=sp"
    logged_tenant=$(azcopy login status --tenant)
    if [[ $? != 0 || "$logged_tenant" != "$tenant_id" ]]; then
        export AZCOPY_SPA_CLIENT_SECRET="$client_secret"
        azcopy login --service-principal --application-id "$client_id" --tenant-id "$tenant_id" || bashio::exit.nok "azcopy login using service-principal(sp) failed"
    fi ;;

  *)
    bashio::exit.nok "only sas and sp (service principal) is supported for now as autht_type" ;;
esac


# bashio::log.info "Found these backups:"
# bashio::log.info "$(ls /backup/)"

bashio::log.info "$(azcopy --version)"

bashio::log.info "Starting Azcopy at $(date +"%Y-%m-%dT%H:%M:%S%z")"
azcopy sync "/backup" "$storage_url" "${params[@]}"

if [ $? -eq 0 ]; then
    bashio::log.info "Azcopy successfully completed at $(date +"%Y-%m-%dT%H:%M:%S%z")"
    bashio::exit.ok
else
    bashio::exit.nok "There was an error with Azcopy"
fi
