//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
//**** Desc *****
//Get funds from users
//Withdraw funds
//Set a minimum funding value in USD
//******************

contract FundMe{
    uint public minimumUSD = 50*1e18;
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable{ // payable --> indicates that a function is able to receive Ether
        // msg --> global variable refers to the current message 
        //that is being processed. It is an instance of the Message struct, 
        //which contains information about the message and its sender.
        require(msg.value >= minimumUSD, "Didn't send enough!"); 
        funders.push(msg.sender);
        //18 decimals
        
    }
    function getPrice() public view returns(uint256){
        //ABI
        //Address = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419 --> ETH -> USD
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
        (,int256 price,,,) = priceFeed.latestRoundData();
        //ETH in terms of USD
        //3000.00000000
        return uint256(price*1e10); // 1**10 = 10000000000;
    }
    function getConversionRate(uint256 ethAmount)public view returns(uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUSD = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUSD;
    }
    function getVersion() public view returns(uint){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
        return priceFeed.version();
    }
    //function withdraw{}
}