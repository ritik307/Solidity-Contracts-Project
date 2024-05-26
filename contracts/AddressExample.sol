//SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract AddressExample {
    address public myAddress;
    function setAddress(address _newAddress) public {
        myAddress = _newAddress;
    }
    function getBalanace() public view returns(uint){
        return myAddress.balance;
    }
}