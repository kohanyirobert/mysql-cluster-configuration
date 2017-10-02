#! /usr/bin/env bash
set -o errexit
set -o nounset

find "$MYSQL_BACKUPDIR" \
  -mtime +28 \
  -name "*.sql.bz2" \
  | xargs \
    --replace={} \
    --no-run-if-empty \
    rm {}
