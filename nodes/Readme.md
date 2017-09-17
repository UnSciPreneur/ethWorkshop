# Setup of local Ethereum node(s)

## Software requirements

Besides the code in this repository you will need the following software to run your own Ethereum node:
* *geth* in version 1.6.7 or higher [https://geth.ethereum.org/downloads/](https://geth.ethereum.org/downloads/)
* *mist* in version 0.9.0 or higher [https://github.com/ethereum/mist/releases](https://github.com/ethereum/mist/releases) (lower version numbers will not support the language level of the smart contracts used in this tutorial!)                        

## Overview

Three main scripts exist for nodes 0 and 1:

1. **init_eth_node_\*.sh**: Run this script once to setup the node.
2. **run_eth_node_\*.sh**: After the init the node can be started again with this script. This opens up the JavaScript Console.
3. **bckgr_run_eth_node_\*.sh**: Starts node in the background. `geth attach` can be used as mentioned below to use the console. _Note:_ Running geth in background implies that you need to kill the process using `kill <procid>`. You can get the relevant process id by running `ps -aux |grep geth`.

Those will exposed the following configurations:

#### eth_node_0:
- port 40303 (for inter node communication)
- rpcport 18545
- networkid 31297718
- All output is logged to the logfile *eth_0.log*

#### eth_node_1:
- default port 50303
- rpcport 28545
- networkid 31297718
- All output is logged to the logfile *eth_1.log*

**Note:** If you have only one (physical/logical) machine and still want to test a network with two nodes you can use both configurations for *eth_node_0* and *eth_node_1* in parallel. (This explains why the ports for both configurations differ.) However, if you are part of a network on multiple machines - which we assume in the following - you will need only one node: *eth_node_0*. 

## Getting started

### Creating the genesis block

**Note:** In the following we assume that you are running code in a shell (bash) and that your current working directory is the `./nodes` directory in the repository root.

Before you start the node you have to initialize it by running
```
./init_eth_node_0.sh
```
This will take the genesis block definition from `genesis.json` and create the genesis block. Without this block the node will refuse to connect to other nodes (with the same network ID and the same genesis block).

### Creating accounts

You can create new accounts (for *node_0*) from the console like this:
```bash
geth --datadir="data_eth_0" account new
```
The process will ask for a passphrase which is needed whenever the account is unlocked. You need not necessarily unlock any account when starting the node. However, it will make things simpler once you start experimenting with your node. Hence our scripts try to unlock account 0 on startup.

We suggest that you store your password in the file `.gethPrivatePassword_0`. The start-up scripts will then use this file to unlock the account. But you can also choose to enter the password manually every time you start up the node. In this case you should remove the corresponding logic from `run_eth_node_0.sh` and `bckgr_run_eth_node_0.sh`.

### Starting the node

Start your node with an interactive shell by running
```bash
./run_eth_node_0.sh
```
In this console you can use loads of commands to control the behaviour of your node. A good overview about the console and the available commands is given [here](https://github.com/ethereum/go-ethereum/wiki/JavaScript-Console).

Maybe you want to start by trying (one of) the following:
```
eth.blockNumber
eth.hashrate
admin.peers
admin.nodeInfo.enode
```

You should see that you are at block number 0, the hashrate should turn positive after some time as the node is configured to start mining. Initially, there should be no peers but we are going to change this in the next step.

### Connecting to the nodes on the server

The command `admin.nodeInfo.enode` did give you a cryptic identifier of your node. These are used to connect to other nodes in the peer-to-peer network. We have prepared a small network of three nodes running on three different machines. You can add each of those by running on of the following commands. Afterwards check `admin.peers` to see whether the nodes have been added successfully.

```
admin.addPeer("enode://2f2147e2065c87ab8eb43b1b894c27af9db9a9c4bce5174f763e0ffeb35f2c1d043a8cbf88259a7b3c24fe1d7448524b95432879e743af7e3ee05ab69eeda9f2@136.243.110.29:40303")
admin.addPeer("enode://99935e736a102fea5d65ee70467f9884823c215739fc64d3abaf9de29204cb2056ab5c9fc3f4cebba7bbb2cf6714cf8e5421e0a65a6575e34d2fd6e9c7b9edb5@18.194.25.235:40303")
admin.addPeer("enode://d32e89d63d4bf2955fbb7cf9a7bd4d93cd7b5233d5a2a78652066eabde5f5e023fed86a262585c83d7499232030f302d9470fd163dd9ff2dba6550f8be532e94@18.194.20.255:40303")
```

Now your network should be fully functional.

## Shutting down nodes and running nodes in the background

If you want to stop a node that has a JavaScript console (started by *run_eth_node_\*.sh*) simply type `exit` in the geth console or use `Ctrl+D` to shut down a geth instance.

You can also run the node in background. This way the process keeps running once the terminal exits (as it would be the case if you start the script remotely and then close your ssh connection). To start the node in the background simply run
```bash
./bckgr_run_eth_node_0.sh
```

This will start up the node but not add any peers. To do so you need to open a console to the node. In order to attach to a node running in the background (started by *bckgr_run_eth_node_\*.sh*) run
```bash
geth attach http://localhost:18545
``` 
or 
```bash
geth attach data_eth_0/geth.ipc
```
The first one only works if rpc is available (but could also be used to talk to a remote node) while the latter always works for geth instances on the same machine.
 
Using `Ctrl+D` de-attaches from the console **without** killing the node.

## Using mist as a graphical user interface

Once your geth is attached to the private network and you have exposed the rpc interface it is easy to use mist with this geth instance. Simply run
```
mist --rpc data_eth_0/geth.ipc
```

Your geth is configured as a mining node. After some time you should see a positive balance in the account you have created in an earlier step. This account serves as the coinbase for your mining and as your source of play ether. 