// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract removeItemFromArray {
    // execution cost	39446 gas
    uint256[] public nums = [1, 2, 3, 4];

    // execution cost	679050 gas
    // uint[] public nums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
    //                      11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
    //                      21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
    //                      31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
    //                      41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
    //                      51, 52, 53, 54, 55, 56, 57, 58, 59, 60,
    //                      61, 62, 63, 64, 65, 66, 67, 68, 69, 70,
    //                      71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
    //                      81, 82, 83, 84, 85, 86, 87, 88, 89, 90,
    //                      91, 92, 93, 94, 95, 96, 97, 98, 99, 100,
    //                      101, 102, 103, 104, 105, 106, 107, 108, 109, 110];

    // 往前移的值越多(length - 1 - _index)，gas 越高
    function remove(uint256 _index) public {
        require(_index < nums.length, "index invalid");

        for (uint256 i = _index; i < nums.length - 1; i++) {
            nums[i] = nums[i + 1];
        }

        nums.pop();
    }

    function getNums() public view returns (uint256[] memory) {
        return nums;
    }

    function test() external {
        nums = [1, 2, 3, 4, 5];
        remove(2);
        assert(nums[0] == 1);
        assert(nums[1] == 2);
        assert(nums[2] == 4);
        assert(nums[3] == 5);
        assert(nums.length == 4);

        nums = [1];
        remove(0);
        assert(nums.length == 0);
    }
}
