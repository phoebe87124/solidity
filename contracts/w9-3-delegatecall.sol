// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.9;
/*
A calls B, sends 100 wei
        B calls C, sends 50 wei
A --->  B --->  C
                msg.sebder = B
                msg.value = 50
                execute code on C's state variables
                use ETH in C

A calls B, sends 100 wei
        B delegatecall C
A --->  B --->  C
                msg.sebder = A
                msg.value = 100
                execute code on B's state variables
                use ETH in B
*/

contract TestDelegateCall {
    // 變數儲存一定要跟 delegatecall 的合約格式相同，否則 storage slot 的格式會不一樣
    // address public owner;
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) external payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract DelegateCall {
    uint public num;
    address public sender;
    uint public value;

    function setVars(address _test, uint _num) external payable {
        // _test.delegatecall(abi.encodeWithSignature("setVars(uint256)", _num));
        (bool success, bytes memory data) = _test.delegatecall(abi.encodeWithSelector(TestDelegateCall.setVars.selector, _num));
        require(success, "delegatecall failed");
    }
}