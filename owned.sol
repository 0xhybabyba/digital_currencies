pragma solidity ^0.8.0;

contract Owned{
    address owner;
    address candidate;
    constructor() {
        owner = msg.sender;
    }

    modifier ownerOnly(){
        require(msg.sender == owner);
        _;
    }

    function changeOwner(address newOwner) ownerOnly public{
        candidate = newOwner;
    }

    function approveOwner() public {
        require(msg.sender == candidate);
        owner = candidate;
    }
}
