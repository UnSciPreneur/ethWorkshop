# Setup of local Ethereum node(s)

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

**Note:** In the following we assume that you are running code in a shell (bash) and that your current working directory is the `nodes` directory in the repository root.

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
In this console you can use loads of commands to control the behaviour of your node. A good overview about the console and the available commands is given here:
                                                                                     https://github.com/ethereum/go-ethereum/wiki/JavaScript-Console

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
admin.addPeer("enode://f6f848ca87cc0e113e224607569be1e3e1fd13e571faead417ee92509f25daeb7e2ff75fe1f29af099cb3520fd5e4a5c698b0477289bb189afd1a4c7285fad5c@78.47.252.168:40303")
admin.addPeer("enode://b42909f17025b12ef909b6b4ad9c784023be0ed36c18433507ea0b68c52e83f1ec66b3016536099ce65ce13fa0afb0b30dcfe4cdef114dca8eb9171ca14e619c@78.47.252.169:40303")
admin.addPeer("enode://41255274505a6daaadb9d43bf7029354969ba039b1730eeac805bed5ca72732e5147d2f027d14a0e252ba5e9be6752ef3aaeeda2b44b750252e0ae82e0523615@136.243.110.29:40303")
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
 
Using `Ctrl+D` de-attaches from the console **without** killing the node.
