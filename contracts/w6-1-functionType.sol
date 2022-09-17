// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract functionType {
    function funcView() public view returns (uint256) {
        return address(this).balance;
    }

    // cannot called from outside
    function funcInternal() internal pure returns (uint256) {
        return 100;
    }

    // cannot called from outside
    function funcPrivate() private pure returns (uint256) {
        return 99;
    }

    function funcExternal() external pure returns (uint256) {
        return 88;
    }

    function callPrivate() public pure returns (uint256) {
        return funcPrivate();
    }

    function callInternal() public pure returns (uint256) {
        return funcInternal();
    }

    // compile fail - external function cannot called by self
    // function callExterval() public pure {
    //     funcExternal();
    // }
}

contract functionTypeChildren is functionType {
    function childCallInternal() public pure returns (uint256) {
        return funcInternal();
    }

    // compile fail - private function cannot called by child
    // function childCallPrivate () public pure returns (uint) {
    //     return funcPrivate();
    // }

    // compile fail - external function cannot called by child
    // function childCallExternal () public pure returns (uint) {
    //     return funcExternal();
    // }

    function childCallPrivatePublic() public pure returns (uint256) {
        return callPrivate();
    }
}
