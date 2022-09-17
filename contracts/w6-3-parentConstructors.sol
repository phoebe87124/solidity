// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract A {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

contract B {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

contract C1 is A("AAA"), B("BBB") {}

contract C2 is A, B {
    constructor(string memory _name, string memory _text) A(_name) B(_text) {}
}

// order of execution
// B -> A -> C3
contract C3 is B, A("AAA") {
    constructor(string memory _name, string memory _text) B(_text) {}
}
