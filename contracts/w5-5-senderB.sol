// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract B {
    function getSender() public view returns (address) {
        return msg.sender;
    }

    function getOrigin() public view returns (address) {
        return tx.origin;
    }
}
