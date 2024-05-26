//SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract ExampleWrapAround {
    uint8 public myUint = 250;

    function decrement() public{
        myUint--;
    }
    function increment() public{
        unchecked{
            myUint++;
        }
        
    }
}