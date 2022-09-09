// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract storageType {
    // function 外全部都是 storage
    string[] public numArray = ["1", "2", "3"];

    function editArrayByStorage() public {
        // 鏈上的值會被改變
        string[] storage newArrStorage = numArray;
        newArrStorage[1] = "777";
    }

    function editArrayByMemory() public view {
        // 鏈上的值不會被改變
        string[] memory newArrMemory = numArray;
        newArrMemory[1] = "777";
    }
}
