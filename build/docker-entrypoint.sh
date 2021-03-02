#!/bin/bash
set -ex

SECRET_KEY_FILE=/radicle-seed/secret.key

NODE_PEER_PORT=10001
NODE_SERVICE_PORT=8888
ROOT_SEED_DATA=/radicle/seed

SEED_NODE_BINARY=/radicle/seed-node

DOCKER_HOST=0.0.0.0

if [[ -n $1 ]]; then
  SECRET_KEY_FILE=$1
fi

if [[ -n $LOG_LEVEL ]]; then
  LOG_LEVEL=$LOG_LEVEL
else
  LOG_LEVEL=debug
fi

if [[ ! -f $SECRET_KEY_FILE ]]; then
  echo "No secret found, auto generating one into default location: ${SECRET_KEY_FILE}"
  bash -c "/radicle/key-util --filename ${SECRET_KEY_FILE}"
fi

if [[ -n $_DAPPNODE_GLOBAL_HOSTNAME ]]; then
  PUBLIC_ADDRESS=$_DAPPNODE_GLOBAL_HOSTNAME
fi

if [[ -n $PUBLIC_ADDRESS ]]; then
 PUBLIC_CMD="--public-addr ${PUBLIC_ADDRESS}:${NODE_PEER_PORT}"
fi


bash -c "${SEED_NODE_BINARY} --root ${ROOT_SEED_DATA} --log ${LOG_LEVEL} --peer-listen ${DOCKER_HOST}:${NODE_PEER_PORT} --http-listen ${DOCKER_HOST}:${NODE_SERVICE_PORT} ${PUBLIC_CMD} --name ${NAME}  --assets-path /radicle/seed/ui/public < ${SECRET_KEY_FILE}"
