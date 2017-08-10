#!/bin/bash

RPCPORT=18545
ENODE="$(curl -X POST --data '{"jsonrpc":"2.0","method":"admin_nodeInfo","params":[],"id":74}' localhost:${RPCPORT} |jq '.result.enode')"

generate_post_data()
{
  cat <<EOF
{   "jsonrpc":"2.0",
    "method":"admin_addPeer",
    "params":[${ENODE}],
    "id":74
    }
EOF
}

echo -e "$(generate_post_data)"

curl -X POST --data "$(generate_post_data)" localhost:${RPCPORT}

# vorher dazu: 1>/dev/null
