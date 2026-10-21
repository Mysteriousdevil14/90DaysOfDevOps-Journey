#!/usr/bin/env bash
set -Eeuo pipefail

# Usage: ./backup.sh SOURCE_DIRECTORY BACKUP_DESTINATION
if [[ $# -ne 2 ]]; then
  echo "Usage: $0 SOURCE_DIRECTORY BACKUP_DESTINATION" >&2
  exit 2
fi

SOURCE_DIR=${1%/}
BACKUP_DIR=$2

if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "Error: source directory does not exist: $SOURCE_DIR" >&2
  exit 1
fi

if ! mkdir -p -- "$BACKUP_DIR"; then
  echo "Error: could not create backup destination: $BACKUP_DIR" >&2
  exit 1
fi

if [[ ! -w "$BACKUP_DIR" ]]; then
  echo "Error: backup destination is not writable: $BACKUP_DIR" >&2
  exit 1
fi

source_parent=$(dirname -- "$SOURCE_DIR")
source_name=$(basename -- "$SOURCE_DIR")
timestamp=$(date +%Y-%m-%d_%H-%M-%S)
archive="$BACKUP_DIR/backup-${timestamp}.tar.gz"
temporary_archive="${archive}.tmp"

cleanup() {
  rm -f -- "$temporary_archive"
}
trap cleanup EXIT

if ! tar -czf "$temporary_archive" -C "$source_parent" -- "$source_name"; then
  echo "Error: archive creation failed" >&2
  exit 1
fi

if ! tar -tzf "$temporary_archive" >/dev/null; then
  echo "Error: archive verification failed" >&2
  exit 1
fi

mv -- "$temporary_archive" "$archive"
size=$(du -h -- "$archive" | awk '{print $1}')
echo "Backup created and verified: $archive"
echo "Archive size: $size"

# Remove only this script's backup files older than 14 days.
deleted=0
while IFS= read -r -d '' old_backup; do
  if rm -- "$old_backup"; then
    ((deleted += 1))
    echo "Deleted old backup: $old_backup"
  else
    echo "Warning: could not delete old backup: $old_backup" >&2
  fi
done < <(find "$BACKUP_DIR" -maxdepth 1 -type f -name 'backup-*.tar.gz' -mtime +14 -print0)

echo "Old backups deleted: $deleted"
