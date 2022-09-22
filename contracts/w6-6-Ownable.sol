// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOnwer() {
        require(msg.sender == owner, "Not Owner");
        _;
    }

    function setOwner(address _newOwner) external onlyOnwer {
        require(_newOwner != address(0), "Invalid Address");
        owner = _newOwner;
    }

    function onlyOnwerCall() external onlyOnwer {}

    function anyoneCanCall() external {}
}
