#! /usr/bin/env bash
set -o errexit
set -o nounset

hostname="$(hostname)"

if [ "$hostname" == "be0" ]
then
  ndbd_nodeid="1"
elif [ "$hostname" == "be1" ]
then
  ndbd_nodeid="2"
else
  exit 1
fi

"$MYSQL_BASEDIR/bin/ndbd" \
  --ndb-connectstring=be0,be1 \
  --ndb-nodeid="$ndbd_nodeid"
