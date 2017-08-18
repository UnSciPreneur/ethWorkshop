pragma solidity ^0.4.11;
// We have to specify what version of compiler this code will compile with

contract Game {
  /* mapping field below is equivalent to an associative array or hash.
  The key of the mapping is game name stored as type bytes32 and value is
  an unsigned integer to store the vote count
  */
  mapping (bytes32 => uint8) public popularityScore;
  bytes32[] public gameList;

  // Constructor
  function Game(bytes32[] games) payable {
    gameList = games;
  }

  // This is the syntax for a default function that will be executed if ether is sent to the smart contract.
  // If the smart contract should be able to receive ether, this function is mandatory. If it does not exist
  // transactions containing ether will be sent back.
  function() payable {}

  //  Here we define our Game Functions: They accept sent ether and play a corresponding game with it
  function betOdd() payable returns (bool) {
    uint result = rouletteResult();
    voteForGame('Odd');
    if (result != 0 && result%2 == 1) {
      msg.sender.transfer(2*msg.value);
      return true;
    } else {
      return false;
    }
  }

  function betEven() payable returns (bool) {
    uint result = rouletteResult();
    voteForGame('Even');
    if (result != 0 && result%2 == 0) {
      msg.sender.transfer(2*msg.value);
      return true;
    } else {
      return false;
    }
  }

  function betZero() payable returns (bool) {
    uint result = rouletteResult();
    voteForGame('Zero');
    if (result == 0) {
      msg.sender.transfer(36*msg.value);
      return true;
    } else {
      return false;
    }
  }

  //  Helper Functions
  function rouletteResult() returns (uint) {
    return uint(block.blockhash(block.number-1))%37;
  }

  // This function returns the total votes a game has received so far
  function totalVotesFor(bytes32 game) returns (uint8) {
    if (validGame(game) == false) revert();
    return popularityScore[game];
  }

  // This function increments the vote count for the specified game. This
  // is equivalent to casting a vote
  function voteForGame(bytes32 game) {
    if (validGame(game) == false) revert();
    popularityScore[game] += 1;
  }

  function validGame(bytes32 game) returns (bool) {
    for(uint i = 0; i < gameList.length; i++) {
      if (gameList[i] == game) {
        return true;
      }
    }
    return false;
  }
}