#!/bin/bash

# ipc is the only api enabled by default (can be disabled with --ipcdisable)
# default rpc port is 8545
# default ws  port is 8546

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
# get the actual ip of the interface
RPCADDRESS=`ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'`
RPCPORT=18545
ETHERBASE=0

geth --password .gethPrivatePassword_0 --unlock 0 --datadir="data_eth_0" --identity "eth_node_0" --verbosity 4 --port 30303 --rpc --rpcaddr=${RPCADDRESS} --rpcport ${RPCPORT} --rpcapi "admin,db,eth,debug,miner,net,shh,txpool,personal,web3" --networkid ${NETWORKID} --mine --minerthreads 1 --etherbase $ETHERBASE console 2>>"eth_0.log"
