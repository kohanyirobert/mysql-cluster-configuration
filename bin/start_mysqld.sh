#! /usr/bin/env bash
set -o errexit
set -o nounset

hostname="$(hostname)"

if [ "$hostname" == "be0" ]
then
  mysqld_nodeid="252"
elif [ "$hostname" == "be1" ]
then
  mysqld_nodeid="253"
else
  exit 1
fi

"$MYSQL_BASEDIR/bin/mysqld" \
  --no-defaults \
  --basedir="$MYSQL_BASEDIR" \
  --bind-address=0.0.0.0 \
  --binlog-format=ROW \
  --binlog_cache_size=1048576 \
  --binlog_stmt_cache_size=1048576 \
  --character-set-filesystem=utf8 \
  --character-set-server=utf8 \
  --collation-server=utf8_hungarian_ci \
  --datadir="$MYSQL_DATADIR/mysqld_$mysqld_nodeid" \
  --general-log-file="$MYSQL_LOGDIR/mysqld_$mysqld_nodeid-general.log" \
  --general-log=0 \
  --innodb_buffer_pool_size=6G \
  --innodb_lock_wait_timeout=15 \
  --innodb_rollback_on_timeout=1 \
  --lc-messages-dir="$MYSQL_BASEDIR/share" \
  --lc-messages=en_US \
  --log-bin="mysqld_$mysqld_nodeid-bin" \
  --log-error="$MYSQL_LOGDIR/mysqld_$mysqld_nodeid-error.log" \
  --log-warnings=1 \
  --max_connect_errors=100 \
  --max_connections=4096 \
  --table_cache=8192 \
  --pid-file="$HOME/mysqld_$mysqld_nodeid.pid" \
  --port=3306 \
  --relay-log="mysqld_$mysqld_nodeid-relay" \
  --server-id="$mysqld_nodeid" \
  --socket="$HOME/mysqld_$mysqld_nodeid.sock" \
  --sync-binlog=1 \
  --tmpdir=/tmp \
  --user=root \
  --wait_timeout=1500 \
  &
