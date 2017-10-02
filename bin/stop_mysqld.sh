#! /usr/bin/env bash
set -o errexit
set -o nounset

"$MYSQL_BASEDIR/bin/mysqladmin" \
  --host=127.0.0.1 \
  --port=3306 \
  --user=root \
  shutdown
