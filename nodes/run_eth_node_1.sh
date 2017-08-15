#!/bin/bash

# ipc is the only api enabled by default (can be disabled with --ipcdisable)
# default rpc port is 8545
# default ws  port is 8546
# default port for peer discovery is 30303

# Define a few key parameters
NETWORKID=31297718
# get the actual ip of the interface
RPCADDRESS=`ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'`
RPCPORT=28545
PORT=50303
# index of the account to use
ETHERBASE=0

geth --nodiscover --datadir="data_eth_1" --identity "eth_node_1" --verbosity 4 --port ${PORT} --rpc --rpcaddr=${RPCADDRESS} --rpcport ${RPCPORT} --rpccorsdomain "*" --rpcapi "admin,db,eth,debug,miner,net,shh,txpool,personal,web3" --networkid ${NETWORKID} --mine --minerthreads 1 --etherbase ${ETHERBASE} console 2>>"eth_1.log"