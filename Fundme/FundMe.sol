//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "./PriceConverter.sol";
//**** Desc *****
//Get funds from users
//Withdraw funds
//Set a minimum funding value in USD
//******************

contract FundMe{
    using PriceConverter for uint256;
    uint public minimumUSD = 50*1e18;
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    address public owner;
    constructor(){
        owner = msg.sender;
    }

    function fund() public payable{ // payable --> indicates that a function is able to receive Ether
        // msg --> global variable refers to the current message 
        //that is being processed. It is an instance of the Message struct, 
        //which contains information about the message and its sender.
        require(msg.value.getConversionRate() >= minimumUSD, "Didn't send enough!"); 
        funders.push(msg.sender);
        //18 decimals
    }
    
    function withdraw() public onlyOwner{
        
        //1. transfer ... Auto revert if failed
        //msg.sender = adress
        //payable(msg.sender) = payable address
        payable(msg.sender).transfer(address(this).balance);

        //2. send ... need require to revert if failed
        require(payable(msg.sender).send(address(this).balance),"Failed to send Eth");

        //3. call ... need require to revert if failed
        (bool callSuccess, /*bytes memory dataReturned*/) = payable(msg.sender).call{value : address(this).balance}("");
        require(callSuccess,"Failed to send Eth");
    }
    modifier onlyOwner {
        require(msg.sender==owner,"Sender is not the owner!!!");
        _; // priority
    }
}