#!/bin/bash
script_dir=$(dirname $0)
absolute=$(readlink -f ${script_dir})
data_folder=${absolute}/data_eth_1
if [ ! -d ${data_folder} ]; then
  echo 'Creating folder data_eth_1...'
  mkdir -p ${data_folder}
fi

# Define a few key parameters
NETWORKID=31297718
PORT=50303

geth --datadir="data_eth_1" --identity "eth_node_1" --verbosity 4 --port ${PORT} --ipcdisable --networkid ${NETWORKID} init genesis.json console 2>>"eth_1.log"