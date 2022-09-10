// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract functionSelector {
    // _func = "transfer(address,uint256)"
    function getSelector(string memory _func) external pure returns (bytes32) {
        // bytes(_func) = 0x7472616e7366657228616464726573732c75696e7432353629
        // keccak256(bytes(_func)) = 0xa9059cbb2ab09eb219583f4a59a5d0623ade346d962bcd4e46b11da047c9049b

        return bytes4(keccak256(bytes(_func)));
    }
}

contract Receiver {
    event Log(bytes data);

    function transfer(address, uint256) external {
        emit Log(msg.data);
        // 取 function hash 後的前 4 個bytes
        // 0xa9059cbb
        // 0000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc4
        // 000000000000000000000000000000000000000000000000000000000000006f
    }
}
