#! /usr/bin/env bash
set -o errexit
set -o nounset

start_ndb_mgmd.sh
start_ndbd.sh
