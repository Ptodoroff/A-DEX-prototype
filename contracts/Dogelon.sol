pragma solidity ^0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Dogelon is ERC20 {

constructor ()  ERC20 ("Dogelon","ELON") {
    _mint(msg.sender,500);
 }

function mint(address account, uint256 amount) public  {
      ERC20._mint(account, amount);
       
}
}