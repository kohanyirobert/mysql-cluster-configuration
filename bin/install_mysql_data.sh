#! /usr/bin/env bash
set -o errexit
set -o nounset

hostname="$(hostname)"

if [ "$hostname" == "be0" ]
then
  ndb_mgmd_nodeid="49"
  ndbd_nodeid="1"
  mysqld_nodeid="252"
elif [ "$hostname" == "be1" ]
then
  ndb_mgmd_nodeid="50"
  ndbd_nodeid="2"
  mysqld_nodeid="253"
else
  exit 1
fi

mkdir -pv "$MYSQL_DATADIR/mysqld_$mysqld_nodeid"
mkdir -pv "$MYSQL_DATADIR/ndbd_$ndbd_nodeid"
mkdir -pv "$MYSQL_DATADIR/ndb_mgmd_$ndb_mgmd_nodeid"
mkdir -pv "$MYSQL_LOGDIR"

ln -sfv \
  "$MYSQL_DATADIR/ndb_mgmd_$ndb_mgmd_nodeid/ndb_${ndb_mgmd_nodeid}_cluster.log" \
  "$MYSQL_LOGDIR/ndb_mgmd_${ndb_mgmd_nodeid}_cluster.log"

"$MYSQL_BASEDIR/scripts/mysql_install_db" \
  --basedir="$MYSQL_BASEDIR" \
  --datadir="$MYSQL_DATADIR/mysqld_$mysqld_nodeid" \
  --no-defaults

