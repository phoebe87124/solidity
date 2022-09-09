// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract dataType {
    // Struct
    struct Computer {
        string brand;
        uint256 weight; // (grams)
        uint256 price;
    }

    Computer[] public computers;
    mapping(address => Computer) public computerByOwner;
    mapping(address => string) computerNameByOwner;

    // Array
    function addComputer(
        string memory _brand,
        uint256 _weight,
        uint256 _price
    ) public {
        computers.push(Computer(_brand, _weight, _price));
    }

    // 用 public computers 即可
    // function getComputer(uint _index) public view returns (Computer memory) {
    //     return computers[_index];
    // }

    function deleteComputer(uint256 _index) public {
        delete computers[_index];
    }

    function deleteLastComputer() public {
        computers.pop();
    }

    // Mapping
    function setComputerByOwner(uint256 _index) public {
        computerByOwner[msg.sender] = computers[_index];
    }

    // 用 public computerByOwner 即可，但要自行輸入查詢地址
    // function getComputerByOwner() public view returns (Computer memory) {
    //     return computerByOwner[msg.sender];
    // }

    function getComputerNameByOwner(address _address)
        public
        view
        returns (string memory name)
    {
        return computerByOwner[_address].brand;
    }

    // data set
    // MacBook Pro 13.3x, 1400, 39900
    // MacBook Air 13.6x, 1240, 37900
    // ASUS Vivobook Pro 14.5x, 1680, 54900
    // ACER Swift3 14x, 1200, 25900
    // HP ENVY 13x, 1290, 32900
}
