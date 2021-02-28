#!/bin/bash
set -e

FILE=/radicle-seed/secret.key

if [[ ! -z $1 ]]; then
  FILE=$1
fi

if [[ ! -f $FILE ]]; then
  echo "No secret found, auto generating one into default location: $FILE"
  bash -c "/radicle/key-util --filename $FILE"
fi

bash -c "/radicle/seed-node --root /radicle-seed --peer-listen ${HOST}:12345 --http-listen ${HOST}:8888 --name ${NAME} --assets-path seed/ui/public < /radicle-seed/secret.key"
