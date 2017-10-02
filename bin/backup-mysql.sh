#! /usr/bin/env bash
set -o errexit
set -o nounset

renice 15 -p $$
ionice -c 3 -p $$

"$MYSQL_BASEDIR/bin/mysqldump" \
  --no-defaults \
  --allow-keywords \
  --databases npli \
  --databases npsf \
  --events \
  --extended-insert \
  --host="$MYSQL_HOST" \
  --master-data=2 \
  --quick \
  --routines \
  --single-transaction \
  --triggers \
  | pbzip2 \
  > "$MYSQL_BACKUPDIR/$(date +%FT%H-%M-%S).sql.bz2"
