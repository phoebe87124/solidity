pragma solidity >=0.7.0 <0.9.0;

contract byteTest {
    // byte public b; 會報錯
    bytes public bs;
    bytes1 public b1;
    bytes16 public b16;
    bytes32 public b32;

    function setBytes(bytes memory _bs) public {
        bs = _bs;
    }

    function setBytes1(bytes1 _b1) public {
        b1 = _b1;
    }

    function setBytes16(bytes16 _b16) public {
        b16 = _b16;
    }

    function setBytes32(bytes32 _b32) public {
        b32 = _b32;
    }
}