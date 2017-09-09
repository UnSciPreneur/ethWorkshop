#!/bin/bash

## README

# This script starts up a geth instance for a private network. Hence we deviate from standard ports to
# avoid a collision with a mainnet instance (network id 0). If you want to open the RPC interface for
# external connections set $RPCEXTERNAL=1. This will make geth listen to the IP address of your
# eth0 device. Else it will listen to 127.0.0.1 which is perfectly fine if your application runs on the
# same machine as the geth client.

RPCEXTERNAL=0

# ipc is the only api enabled by default (can be disabled with --ipcdisable)
# default rpc port is 8545
# default ws  port is 8546
# default port for peer discovery is 30303

DIR="$(dirname "${BASH_SOURCE[0]}")"
echo "Running script in directory $DIR"
cd $DIR

if [[ ! -e .gethPrivatePassword_0 ]]
then
    echo "Expecting file .gethPrivatePassword_0 in this directory.";
    echo ".gethPrivatePassword_0 must contain the password to unlock account 0";
    exit;
fi

# Define a few key parameters
NETWORKID=31297718


if [[ $RPCEXTERNAL == 1 ]]
then
    # get the actual ip of the interface (replace 'eth0' by 'wlan0' if you are using wireless lan)
    RPCADDRESS=`ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'`
else
    RPCADDRESS="127.0.0.1"
fi
RPCPORT=18545
PORT=40303
# index of the account to use
ETHERBASE=0

echo "Listening for RPC connections on $RPCADDRESS:$RPCPORT";
geth --nodiscover --password .gethPrivatePassword_0 --unlock 0 --datadir="data_eth_0" --identity "eth_node_0" --verbosity 4 --port ${PORT} --rpc --rpcaddr=${RPCADDRESS} --rpcport ${RPCPORT} --rpccorsdomain "*" --rpcapi "admin,db,eth,debug,miner,net,shh,txpool,personal,web3" --networkid ${NETWORKID} --mine --minerthreads 1 --etherbase ${ETHERBASE} console 2>>"eth_0.log"
