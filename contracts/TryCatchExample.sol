//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract WillThrow{
    error NotAllowedError(string); //defining custom exceptions
    function aFunction() pure public{
        // require(false, "This is an example error message");
        // assert(false);
        revert NotAllowedError("You are not allowed");
    }
}

contract ErrorHandlinhg{
    event ErrorLogging(string reason);
    event ErrorLogCode(uint code);
    event ErrorLogBytes(bytes lowlevelData);
    function catchTheError() public{
        WillThrow will = new WillThrow();
        try will.aFunction(){
            // if code works
        }catch Error(string memory reason){ //Trigger with require
            emit ErrorLogging(reason);
        }catch Panic(uint errorCode){ //Trigger with assert
            emit ErrorLogCode(errorCode);
        } catch (bytes memory lowlevelData){ //Trigger with custom messages
            emit ErrorLogBytes(lowlevelData);
        }
    }
}

