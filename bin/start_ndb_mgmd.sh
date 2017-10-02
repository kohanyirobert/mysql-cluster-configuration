#! /usr/bin/env bash
set -o errexit
set -o nounset

hostname="$(hostname)"

if [ "$hostname" == "be0" ]
then
  ndb_mgmd_nodeid="49"
elif [ "$hostname" == "be1" ]
then
  ndb_mgmd_nodeid="50"
else
  exit 1
fi

"$MYSQL_BASEDIR/bin/ndb_mgmd" \
  --config-file="$HOME/conf/ndb_mgmd.ini" \
  --configdir="$MYSQL_DATADIR/ndb_mgmd_$ndb_mgmd_nodeid" \
  --ndb-connectstring=be0,be1 \
  --ndb-nodeid="$ndb_mgmd_nodeid" \
  --reload
