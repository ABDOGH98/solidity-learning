//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./SimpleStorage.sol";

contract StorageFactory{
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public{
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }
    function sfStore(uint _ssIndex, uint _ssNumber) public{
        // Address
        //ABI : Application Binary Interface
        SimpleStorage simpleStorage = simpleStorageArray[_ssIndex];
        simpleStorage.store(_ssNumber);
    }
    function sfStore(uint _ssIndex) public view returns(uint){
        // Address
        //ABI : Application Binary Interface
        SimpleStorage simpleStorage = simpleStorageArray[_ssIndex];
        return simpleStorage.retrieve();
    }

}
