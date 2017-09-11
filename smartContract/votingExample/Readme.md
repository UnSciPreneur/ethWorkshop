# Ethereum Voting Dapp

This source code is from [https://github.com/maheshmurthy/ethereum_voting_dapp/chapter3](https://github.com/maheshmurthy/ethereum_voting_dapp/chapter3) 
which is part of a 3 piece tutorial on Dapp programming by *Mahesh Murthy*. You can find his full tutorial at [Part 1](https://medium.com/@mvmurthy/full-stack-hello-world-voting-ethereum-dapp-tutorial-part-1-40d2d0d807c2), [Part 2](https://medium.com/@mvmurthy/full-stack-hello-world-voting-ethereum-dapp-tutorial-part-2-30b3d335aa1f), [Part 3](https://medium.com/@mvmurthy/full-stack-hello-world-voting-ethereum-dapp-tutorial-part-3-331c2712c9df).

## Getting started

The demo code expects an ethereum RPC interface at `127.0.0.1:18545`. So you might want to run a node from the `nodes` directory or the testrpc (`testrpc.sh` also from the `./nodes` directory).

Given this requirement you can start this demo by running
```bash
npm install
truffle migrate
npm run dev
```
(Note that the last command is a workaround for the currently defunct `truffle serve`.)
This will start a web server at `127.0.0.1:8080` providing a GUI for the voting contract. 