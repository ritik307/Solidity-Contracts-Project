//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract StractMappingExample{

    struct Transaction{
       uint amount;
       uint timestamp; 
    }

    struct BalanceInfo{
        uint totalBalance;
        uint depositIdx;
        mapping(uint => Transaction) depositLogs;
        uint withdrawalIdx;
        mapping(uint => Transaction) withdrawLogs;
    }
    mapping(address => BalanceInfo)public  balanceLogs;

    function getBalance() view public returns(uint){
        return balanceLogs[msg.sender].totalBalance;
    } 

    function deposit() payable public {
        balanceLogs[msg.sender].totalBalance += msg.value;
        Transaction memory deposiTransaction = Transaction(msg.value,block.timestamp);
        uint depositIdx = balanceLogs[msg.sender].depositIdx;
        balanceLogs[msg.sender].depositLogs[depositIdx] = deposiTransaction;
        balanceLogs[msg.sender].depositIdx++;
    }

    function withdraw(address payable _to,uint _amount) payable public{
       balanceLogs[msg.sender].totalBalance -= _amount;
        Transaction memory withdrawTransaction = Transaction(msg.value,block.timestamp);
        uint withdrawalIdx = balanceLogs[msg.sender].withdrawalIdx;
        balanceLogs[msg.sender].depositLogs[withdrawalIdx] = withdrawTransaction;
        balanceLogs[msg.sender].withdrawalIdx++;
        _to.transfer(_amount);
    }
}

