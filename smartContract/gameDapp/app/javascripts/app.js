// Import the page's CSS. Webpack will know what to do with it.
import "../stylesheets/app.css";

// Import libraries we need.
import { default as Web3} from 'web3';
import { default as contract } from 'truffle-contract'

/*
 * When you compile and deploy your Voting contract,
 * truffle stores the abi and deployed address in a json
 * file in the build directory. We will use this information
 * to setup a Voting abstraction. We will use this abstraction
 * later to create an instance of the Voting contract.
 * Compare this against the index.js from our previous tutorial to see the difference
 * https://gist.github.com/maheshmurthy/f6e96d6b3fff4cd4fa7f892de8a1a1b4#file-index-js
 */

import game_artifacts from '../../build/contracts/Game.json'


var Game = contract(game_artifacts);

let games = {"Odd": "game-1", "Even": "game-2", "Zero": "game-3"}

window.playRoulette = function() {
  let gameName = $("#game").val();
  let betAmount = parseInt($("#betAmount").val(), 10);
  try {
    if (typeof betAmount != 'number') {
      $("#msg").html(betAmount + " is not a valid amount of Ether to gamble. typeof returns " + typeof betAmount);
    } else if ( betAmount <= 0) {
      $("#msg").html(betAmount + " is not a valid amount of Ether to gamble. Please use a positive value.");
    } else {
      if (gameName == 'Odd') {
        $("#msg").html("You placed a bet of " + betAmount + " on " + gameName + "! The ball is rolling. Wait for the blockchain which should be coming directly.");
        Game.deployed().then(function(contractInstance) {
          contractInstance.betOdd({gas: 140000, value: betAmount, from: web3.eth.accounts[0]}).then(function (v) {
            console.log(v);
            updateLists();
          });
        });
      } else if (gameName == 'Even') {
        $("#msg").html("You placed a bet of " + betAmount + " on " + gameName + "! The ball is rolling. Wait for the blockchain which should be coming directly.");
        Game.deployed().then(function(contractInstance) {
          contractInstance.betEven({gas: 140000, value: betAmount, from: web3.eth.accounts[0]}).then(function (v) {
            console.log(v);
            updateLists();
          });
        });
      } else if (gameName == 'Zero') {
        $("#msg").html("You placed a bet of " + betAmount + " on " + gameName + "! The ball is rolling. Wait for the blockchain which should be coming directly.");
        Game.deployed().then(function(contractInstance) {
          contractInstance.betZero({gas: 140000, value: betAmount, from: web3.eth.accounts[0]}).then(function (v) {
            console.log(v);
            updateLists();
          });
        });
      } else {
        $("#msg").html("Your input \"" + gameName + "\" is not a valid game. Try using one of the listed games above.");
      }
    }
  } catch (err) {
    console.log(err);
  }
}

function updateLists() {
  let gameNames = Object.keys(games);
  for (var i = 0; i < gameNames.length; i++) {
    let name = gameNames[i];
    Game.deployed().then(function(contractInstance) {
      contractInstance.totalVotesFor.call(name).then(function(callbackValue) {
        $("#" + games[name]).html(callbackValue.toString());
      });
    })
  }
}


$( document ).ready(function() {
  if (typeof web3 !== 'undefined') {
    console.warn("Using web3 detected from external source like Metamask")
    // Use Mist/MetaMask's provider
    window.web3 = new Web3(web3.currentProvider);
  } else {
    console.warn("No web3 detected. Falling back to http://localhost:8545. You should remove this fallback when you deploy live, as it's inherently insecure. Consider switching to Metamask for development. More info here: http://truffleframework.com/tutorials/truffle-and-metamask");
    // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
    window.web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
  }

  Game.setProvider(web3.currentProvider);
  updateLists();
});