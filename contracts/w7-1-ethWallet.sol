// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ethWallet {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable {}

    function withdraw(uint256 _amount) external {
        require(msg.sender == owner, "Not owner.");
        // // use storage data, more gas
        // owner.transfer(_amount);
        payable(msg.sender).transfer(_amount);

        // // other way to transfer
        // (bool sent, ) = msg.sender.call{value: _amount}("");
        // require(sent, "Fail to transfer Ether.")
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
