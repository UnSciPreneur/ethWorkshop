# Creating a first smart contract

## Preparations

### Run geth
For every interaction with the blockchain, the geth client needs to be running. To create a transaction, an account must be unlocked and filled with some ether. This should be automatically given by running the command below.

Start the geth client by running the appropriate script in the folder nodes:
```bash
./run_eth_node_0.sh
```
This opens a console which lets you interact directly with the client. A list of available commands can be found here: https://github.com/ethereum/go-ethereum/wiki/JavaScript-Console .
Additionally all Web3 Javascript APIs can be used: https://github.com/ethereum/wiki/wiki/JavaScript-API .

### Installations

To compile a smart contract and deploy it to the blockchain we need to install a few helper tools.

Install Node.js and npm (npm comes automatically with Node.js)
```bash
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs
```

Install web3 to interact with the Ethereum client from Node.js or a webbrowser. We choose the recent version 0.20.1
```bash
npm install web3@0.20.1
```

Install truffle
```bash
npm install -g truffle
```

## Deploy your first contract

### Setup a truffle project

We need to set up a truffle project, which helps us to deploy the smart contract and interact with it. 
```bash
mkdir myFirstDapp
cd myFirstDapp
npm install -g webpack
truffle init webpack
```
Truffle creates a sample dapp (distributed app aka app on the Ethereum blockchain). The corresponding smart contracts are stored in the directory contracts and the part for the web interaction in app. You can safely delete the ConvertLib.sol and MetaCoin.sol files in the contracts directory for this project. The files in the migration directory are used to deploy the contracts to the blockchain.

### Fill the truffle project with your content
Copy the *sampleContract.sol* into the contracts directory.

Replace the contents of migrations/2_deploy_contracts.js with the contents of *sampleDeploy.js*.

Replace the contents of app/javascripts/app.js with the contents of *sampleApp.js*.

Replace the contents of app/index.html with the contents of *sampleWebpage.html*.

### Deploy the contract to the blockchain
In the directory of the dapp myFirstDapp/ use truffle to deploy the contract
```bash
truffle migrate
```
This compiles the contract and writes it to the Ethereum blockchain. It might take a minute or two to finish. If it does not work, check that your geth account account[0] is unlocked and has enough ether to interact with the blockchain.

## Interact with the contract on the blockchain
In the directory of the dapp myFirstDapp/ open a truffle console
```bash
truffle console
```
You can interact through this console with your contract. For example vote for Rama:
```bash
truffle(default)> Voting.deployed().then(function(contractInstance) {contractInstance.voteForCandidate('Rama').then(function(v) {console.log(v)})})
```

Now you can start the server to interact with the dapp via your webbrowser
```bash
npm run dev
```
You can access the website through your browser at localhost:8080.