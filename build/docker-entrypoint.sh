#!/bin/bash
set -e

FILE=/radicle-seed/secret.key

if [[ ! -f $FILE ]]; then
  echo 'No secret found, auto generating one into default location: /radicle-seed/secret.key'
  (cd /radicle/key-util -- --filename /radicle-seed/secret.key)
fi

bash -c "/radicle/seed-node < /radicle-seed/secret.key  --root /radicle-seed --peer-listen ${HOST}:12345 --http-listen ${HOST}:8888 --name ${NAME} --assets-path seed/ui/public"
