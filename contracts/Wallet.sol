pragma solidity 0.8.15; 

import "../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";                                            /* our token struct will interact with this contract */
import "../node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol";  
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";
                                             
contract Wallet is Ownable{

    using SafeMath for uint256;
    mapping (address=>mapping (bytes32=>uint))  public balances;               /* we create a nested mapping which when queried with an owner address, will return a mapping, containing of the token's symbol which the owner has ( we define the token symbol as a bytes32 , altohugh it could be a string, but we define it as bytes32 in order to be able to handle it interact with it more easily) */

    struct Token {                                                                    /* each token will be represented as a struct */
        bytes32 ticker;
        address tokenAddress;
    }

    bytes32[] public tokenList;    /* we define an array that will sotre the symbols, which we said are going to be of bytes32 type. We do this in order to be able to loop over the tokens */

    mapping (bytes32 => Token) public tokenMapping;   /* we also define a mapping for symbols to the corresponding tokens , in order to be able to easily modify them */

    function addToken (bytes32 ticker,address tokenAddress) external onlyOwner{
        tokenMapping[ticker]=Token(ticker, tokenAddress);                               /* we add the ticker and tokenAddres that we input with this function to the tokenMapping */
        tokenList.push(ticker);                                                            /* we also add the ticker to the ticker array */

    }


    function deposit (uint amount, bytes32 ticker) external payable {
        require(tokenMapping[ticker].tokenAddress!=address(0));
        IERC20(tokenMapping[ticker].tokenAddress).transferFrom(msg.sender,address(this), amount);               /* we invoke transferFrom instead of only transfer , because transferFrom also checks and corrects the spending allowance a.k.a whether the token is approved by the contract first*/
        balances[msg.sender][ticker] = balances[msg.sender][ticker].add(amount);


    }


     function withdraw (uint amount, bytes32 ticker) external {
        require(tokenMapping[ticker].tokenAddress!=address(0));                             /* we check if the token address exists, and we check it agains address(0), bacause if it does not exist, the address value will be set to 0 */
        require(balances[msg.sender][ticker]>=amount, "Insufficient amount.");
        balances[msg.sender][ticker] = balances[msg.sender][ticker].sub(amount);             /* we ajust the balances of the msg sender via the safemath library in order to prevent under flow/ overflow */
        IERC20(tokenMapping[ticker].tokenAddress).transfer(msg.sender,amount);              /* we invoke the transfer function form the IERC20 contract by firstly choosing which token we will transfer ( by accessing the token's address from the tokenMapping mapping) and then we pass the receiver and the amount as arguments to the transfer function, which is from the IERC20 contract   */                 

        


     }



}