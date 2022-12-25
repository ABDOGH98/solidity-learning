//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./SimpleStorage.sol";


contract ExtraStorage is SimpleStorage{

    function store(uint _favNbr) public override{
        favNbr = _favNbr+5;
    }
}