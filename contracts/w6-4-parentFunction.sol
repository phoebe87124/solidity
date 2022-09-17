// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

//    A
//  /   \
// B     C
//  \   /
//    D

contract A {
    event Log(string message);

    function direct() public virtual {
        emit Log("A direct");
    }

    function superFuction() public virtual {
        emit Log("A super");
    }
}

contract B is A {
    function direct() public virtual override {
        emit Log("B direct");
        A.direct();
        // B direct
        // A direct
    }

    function superFuction() public virtual override {
        emit Log("B super");
        super.superFuction();
        // B super
        // A super
    }
}

contract C is A {
    function direct() public virtual override {
        emit Log("C direct");
        A.direct();
        // C direct
        // A direct
    }

    function superFuction() public virtual override {
        emit Log("C super");
        super.superFuction();
        // C super
        // A super
    }
}

contract D is B, C {
    function direct() public override(B, C) {
        A.direct();
        // A direct
    }

    function superFuction() public override(B, C) {
        super.superFuction();
        // C super
        // B super
        // A super
    }
}
