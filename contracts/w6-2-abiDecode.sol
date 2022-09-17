// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract abiDecode {
    struct Person {
        string name;
        uint256 age;
    }

    function encode(
        uint256 _x,
        address _addr,
        string[] calldata _strArr,
        Person calldata _person
    ) public pure returns (bytes memory) {
        return abi.encode(_x, _addr, _strArr, _person);
    }

    function decode(bytes calldata byteData)
        public
        pure
        returns (
            uint256 _x,
            address _addr,
            string[] memory _strArr,
            Person memory _person
        )
    {
        (_x, _addr, _strArr, _person) = abi.decode(
            byteData,
            (uint256, address, string[], Person)
        );
        // return abi.decode(byteData, (uint, address, string[], Person));
    }

    // Official Documentation
    // abi.decode(bytes memory encodedData, (...)) returns (...)
    // ABI-decodes the provided data. The types are given in parentheses as second argument.
    // Example: (uint a, uint[2] memory b, bytes memory c) = abi.decode(data, (uint, uint[2], bytes))

    // input
    // 99,0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,["123","456"],["Bobby",30]

    // result
    // 0x00000000000000000000000000000000000000000000000000000000000000630000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc40000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000016000000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000033132330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000334353600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000001e0000000000000000000000000000000000000000000000000000000000000005426f626279000000000000000000000000000000000000000000000000000000
}
