#!/usr/bin/with-contenv bashio

# Ensure there's a value
bashio::config.has_value daystokeep

backup_dir="/backup"
days_threshold="$(bashio::config daystokeep)"

# Print the initial count of files
initial_count="$(find "$backup_dir" -maxdepth 1 -type f | wc -l)"
bashio::log.info "Number of files in $backup_dir before: $initial_count"

# List files older than the specified number of days
bashio::log.info "Files to be deleted:"
find "$backup_dir" -maxdepth 1 -type f -mtime +"$days_threshold" -exec ls -l {} \;

# Delete files older than the specified number of days
find "$backup_dir" -maxdepth 1 -type f -mtime +"$days_threshold" -delete

# Print the count of files deleted
deleted_count="$((initial_count - $(find "$backup_dir" -maxdepth 1 -type f | wc -l)))"
bashio::log.info "Number of files deleted: $deleted_count"

# Print the remaining count of files
remaining_count="$(find "$backup_dir" -maxdepth 1 -type f | wc -l)"
bashio::log.info "Number of files in $backup_dir after: $remaining_count"
