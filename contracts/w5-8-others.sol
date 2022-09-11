// SPDX-License-Identifier: MT

pragma solidity >=0.8.7;

contract counter {
    uint256 public count;

    function inc() external {
        count++;
    }

    function sec() external {
        count--;
    }
}

contract interableMapping {
    mapping(address => uint256) public balances;
    mapping(address => bool) public inserted;
    address[] public addresses;

    function set(address _address, uint256 _val) external {
        balances[_address] = _val;

        if (!inserted[_address]) {
            inserted[_address] = true;
            addresses.push(_address);
        }
    }

    function getSize() external view returns (uint256) {
        return addresses.length;
    }

    function first() external view returns (uint256) {
        return balances[addresses[0]];
    }

    function last() external view returns (uint256) {
        return balances[addresses[addresses.length - 1]];
    }

    function get(uint256 _index) external view returns (uint256) {
        return balances[addresses[_index]];
    }
}

contract simpleStorage {
    string public text;

    function set(string calldata _text) external {
        text = _text;
    }

    function get() external view returns (string memory) {
        return text;
    }
}
