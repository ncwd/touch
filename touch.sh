#!/bin/bash

set -e

cd $(dirname $(readlink -f "$0"))

. ./common.sh

[[ -n "$1" ]] || {
  echo >&2 "Need to specify branch to touch"
  exit 1
}

tempdir

../git clone -q -b "$1" ssh://git@github.com/ncwd/touch .
NOW=$(date +%s)
LAST=$(cat $(ls -1 checked-* | sort | tail -n1))
FILE=touch-$(date -d @$NOW -u +%Y%m%d-%H%M%S)
echo $NOW >$FILE
../git add $FILE
../git commit -q -m. $FILE
../git push -q
if [[ $((NOW - LAST)) -gt 86400 ]]
then
	echo >&2 "Watchdog not running!"
	exit 2
fi	
