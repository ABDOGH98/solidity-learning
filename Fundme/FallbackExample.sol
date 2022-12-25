//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FallbackExample{
    uint256 public result;
    /* 
        receive function is a special function that is automatically 
        called when a contract receives Ether without explicitly calling 
        any of its functions.
    */
    receive() external payable{
        result = 1 ;
    }
    /* 
        fallback function is a special function that is automatically 
        called when a contract receives Ether without explicitly calling 
        any of its functions and does not have a "receive" function defined.
    */
    fallback() external payable {
        result = 2 ;
    }
}