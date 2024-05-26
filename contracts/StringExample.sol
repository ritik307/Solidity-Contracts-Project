//SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract StringExample{
    string public myString = "My String";
    bytes public myBytes = unicode"My String";

    function compareTwoStrings(string memory _myString) public view returns(bool){
        return keccak256(abi.encodePacked(myString)) == keccak256(abi.encodePacked(_myString));
    }

    function getMyBytesLength()public view returns(uint){
        return myBytes.length;
    }
}