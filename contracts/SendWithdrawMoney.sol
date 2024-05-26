//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract SendWithdrawMoney{
    mapping(address => uint) balanceReceived; 

    function deposit() payable public {
        balanceReceived[msg.sender] += msg.value;
    }
    function getContractBalance() view public returns(uint){
        return address(this).balance;
    }
    function withdrawAllMoney(address payable _to) public {
        uint balanceToSendOut = balanceReceived[_to];
        balanceReceived[msg.sender] = 0;
        _to.transfer(balanceToSendOut);
    }
    function checkAddressBalance(address _addr) view public returns(uint) {
        return balanceReceived[_addr];
    }
    function myBalance() public view returns(uint){
        return address(this).balance;
    }
}

