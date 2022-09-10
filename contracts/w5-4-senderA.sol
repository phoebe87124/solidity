// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract B {
    function getSender() public view returns (address) {}

    function getOrigin() public view returns (address) {}
}

contract A {
    address Baddress = 0xd9145CCE52D386f254917e481eB44e9943F39138;
    B BContract = B(Baddress);

    function getSender() public view returns (address) {
        return msg.sender;
    }

    function getOrigin() public view returns (address) {
        return tx.origin;
    }

    function getBSender() public view returns (address) {
        address sender = BContract.getSender();
        return sender;
    }

    function getBOrigin() public view returns (address) {
        address origin = BContract.getOrigin();
        return origin;
    }
}
