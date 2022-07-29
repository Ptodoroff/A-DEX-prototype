pragma solidity  ^0.8.0;
pragma abicoder v2;


contract Wallet {
    
    enum Side {
        BUY,
        SELL
    }


 /* we create an orderstruct which will represent every order with its details */
struct Order {                              
    uint id;
    address trader;
    bool buyOrder;
    bytes32 ticker;
    uint amount;
    uint price;
}

 mapping (bytes32 => mapping(Side=>Order[])) orderBook; /* we create a mapping with the orderbook for every coin. the mapping takes the ticker of the coin, then if the order is buy or seel */

function getOrderBook (bytes32 ticker, Side side) view public returns (Order[] memory) {
return orderBook[ticker][Side(side)];

}

}