# Setup of local Ethereum node

## Running it

Three main scripts exist for nodes 0 and 1:

1. **init_eth_node_\*.sh**: Run this script once to setup the node.
2. **run_eth_node_\*.sh**: After the init the node can be started again with this script. This opens up the JavaScript Console.
3. **bckgr_run_eth_node_\*.sh**: Starts node in the background. _geth attach_ can be used as mentioned below to use the console. _Note:_ Running geth in background implicates that you need to kill the process using _kill <procid>_. Proper process id can be get using _ps -aux |grep geth_.

Exposed configurations:

eth_node_0:
- default port 30301
- rpcport 8545
- networkid 32582482
- All output is logged to the logfile *eth_0.log*

eth_node_1:
- default port 30302
- rpcport 8546
- networkid 32582482
- All output is logged to the logfile *eth_1.log*

## Working with it

- Closing and shutdown node: Enter _exit_ in the geth console or use _Ctrl+D_.
- Attaching to a running node 0 using  _geth attach ws://localhost:8545_. Using _Strg+D_ de-attaches from it.

A good overview about the console and the available commands is given here:
https://github.com/ethereum/go-ethereum/wiki/JavaScript-Console

## Creating accounts

You can create new accounts from the console like this:
```bash
geth --datadir="data_eth_1" account new
```
The process will ask for a passphrase which is needed whenever the account is unlocked, i.e., when geth is started.

All passphrases used in this project are `"private"`.

## Connecting nodes to each other

In the console, we are able to connect a running node to another one.
The following snippet shows, how this is done:

```
# get enode
node2> admin.nodeInfo.enode

# on node 1, add node 2 as peer (TODO: replace ENODE with enode of node 2)
node1> admin.addPeer(ENODE)

# on node 1, check if node 2 was added successfully
node1> admin.peers
```

## Working together with CertifiCar prototype
Use _account[0]_ of _node 0_ to mine (i.e. get enought money on this account to spawn newly created accounts in the app). 
This is also the reason why _account[0]_ is unlocked at the launch of _node 0_. 
Another reason for unlocking the account is its use in case of choosing mode 'geth' as **addresStorage** in the app. 