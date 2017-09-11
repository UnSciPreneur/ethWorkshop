var Game = artifacts.require("./Game.sol");
module.exports = function(deployer) {
  deployer.deploy(Game, ['Odd', 'Even', 'Zero'], {gas: 500000, value: web3.toWei('10', 'ether')});
};
/* As you can see above, the deployer expects the first argument to be the name of the contract followed by
   constructor arguments. In our case, there is only one argument which is an array of games. The third argument
   is a hash where we specify the gas required to deploy our code. The gas amount varies depending on the size of
   your contract. For the Voting contract, 500000 was sufficient.
*/