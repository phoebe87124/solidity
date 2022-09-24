// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract piggyBank {
    event Deposit(uint256 amount);
    event Withdraw(uint256 amount);

    address public owner = msg.sender;

    receive() external payable {
        emit Deposit(msg.value);
    }

    function withdraw() external {
        require(msg.sender == owner, "Not owner.");
        emit Withdraw(address(this).balance);
        selfdestruct(payable(msg.sender));
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
