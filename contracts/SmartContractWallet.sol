//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;


contract SmartContractWallet{
    address payable public owner;
    mapping(address => uint) public allowance;
    mapping(address => bool) public isAllowedToSend;

    mapping (address => bool) public guardians;
    address payable nextOwner;
    mapping(address => mapping(address => bool)) nextOwnerGuardianVotedBool; // to keep a check that a guardian doesnt vote for same _nextOwner twice
    uint guardiansResetCount;
    uint public constant confirmationsFromGuardiansForReset = 3;
    constructor(){
        owner = payable(msg.sender);
    }

    function setGuardian(address _guardian,bool _isGuardian) public {
        require(owner == msg.sender, "you are not the owner");
        guardians[_guardian] = _isGuardian;
    }

    function proposeNewOwner(address payable _newOwner) public{
        require(guardians[msg.sender],"You are not a guardian of this wallet");
        require(nextOwnerGuardianVotedBool[_newOwner][msg.sender] == false,"You have already voted for the _newOwner");

        if(nextOwner != _newOwner){
            nextOwner = _newOwner;
            guardiansResetCount = 0;
        }
        guardiansResetCount++;
        if(guardiansResetCount >= confirmationsFromGuardiansForReset){
            owner = nextOwner;
            nextOwner = payable (address(0)); // nextOwner is now Nothing
        }
    }

    function setAllowance(address _for, uint _allowance) public{
        require(owner == msg.sender, "You are not the owner");
        allowance[_for] = _allowance;

        if(_allowance > 0){
            isAllowedToSend[_for] = true;
        }else{
           isAllowedToSend[_for] = false; 
        }
    }

    function transfer(address payable _to, uint _amount, bytes memory _payload) public returns(bytes memory){
        if(msg.sender != owner){
            require(isAllowedToSend[msg.sender], "You are not allowed to send amount");
            require(allowance[msg.sender] < _amount, "You are trying to send money more than you have been allowed to");

            allowance[msg.sender] -= _amount;
        }
        (bool success,bytes memory returnData) = _to.call{value: _amount}(_payload);
        require(success,"Aborting, call was not successful");

        return returnData; 
    }
    receive() external payable { }
}