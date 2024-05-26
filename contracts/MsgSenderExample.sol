//SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract AddressExample {
    address public myAddress;
    function getSendersAddress() view public returns(address){
        return msg.sender;
    }
    function updateMyAddress() public{
        myAddress = msg.sender;
    }
}
