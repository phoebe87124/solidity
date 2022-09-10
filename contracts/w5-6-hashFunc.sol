// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract hashFunc {
    function hash(
        string memory text,
        uint256 num,
        address addr
    ) external pure returns (bytes32) {
        return keccak256(abi.encodePacked(text, num, addr));
    }

    // only encode data to bytes
    function encode(string memory text1, string memory text2)
        external
        pure
        returns (bytes memory)
    {
        return abi.encode(text1, text2);
    }

    // encode data to bytes and compress the data
    // result ["AAAA", "BBB"] = ["AAA", "ABBB"] => collision
    function encodePacked(string memory text1, string memory text2)
        external
        pure
        returns (bytes memory)
    {
        return abi.encodePacked(text1, text2);
    }

    // avoid hash collision by adding a number
    function collision(
        string memory text1,
        uint256 x,
        string memory text2
    ) external pure returns (bytes32) {
        return keccak256(abi.encodePacked(text1, x, text2));
    }
}
