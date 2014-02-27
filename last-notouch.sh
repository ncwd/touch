#!/bin/bash

set -e

cd $(dirname $(readlink -f "$0"))

. ./common.sh

[[ -n "$1" ]] || {
  echo >&2 "Need to specify branch to query"
  exit 1
}

tempdir

../git clone -q -b "$1" ssh://git@github.com/ncwd/touch .
NOW=$(date +%s)
LAST=$(cat $(ls -1 touch-* | sort | tail -n1))
echo $((NOW-LAST))
