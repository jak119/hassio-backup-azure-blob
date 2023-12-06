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
    bashio::log.info "Using SAS token. Any Service Principal values (client ID, etc) will be ignored";;

  sp)
    bashio::log.info "Using Service Principal"
    bashio::config.has_value 'tenant_id'
    bashio::config.has_value 'client_id'
    bashio::config.has_value 'client_secret'
    export AZCOPY_SPA_CLIENT_SECRET="$client_secret"
    export AZCOPY_AUTO_LOGIN_TYPE=SPN
    export AZCOPY_SPA_APPLICATION_ID=$client_id
    export AZCOPY_TENANT_ID=$tenant_id
  ;;

  *)
    bashio::exit.nok "only sas and sp (service principal) is supported for now as auth_type" ;;
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
