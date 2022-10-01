// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract AppWorks is ERC721, Ownable {
    // an uint256 variable can call up functions in the Strings library. One example can be, value.toString(). An uint256 can be easily converted into a string.
    using Strings for uint256;

    // Provides counters that can only be incremented, decremented or reset. This can be used e.g. to track the number of elements in a mapping, issuing ERC721 ids, or counting request ids.
    using Counters for Counters.Counter;
    Counters.Counter private _nextTokenId;

    using SafeMath for uint256;

    uint256 public price = 0.01 ether;
    uint256 public constant maxSupply = 100;
    uint256 public totalSupply;

    bool public mintActive = false;
    bool public earlyMintActive = false;
    bool public revealed = false;

    string public baseURI;
    bytes32 public merkleRoot;

    mapping(uint256 => string) private _tokenURIs;
    mapping(address => uint256) public addressMintedBalance;
    mapping(address => uint256) public addressMaxBalance;

    constructor() ERC721("AppWorks", "AW") {}

    // Public mint function - week 8
    function mint(uint256 _mintAmount) public payable {
        if (addressMaxBalance[msg.sender] == 0) {
            setMaxBalance();
        }

        require(mintActive, "Not valid mint time");
        require(
            addressMaxBalance[msg.sender].sub(
                addressMintedBalance[msg.sender]
            ) >= _mintAmount,
            "Over balance"
        );
        require(
            totalSupply.add(_mintAmount) <= maxSupply,
            "Reach max supply amount"
        );
        require(msg.value == price.mul(_mintAmount), "Mismatch value");

        totalSupply = totalSupply.add(_mintAmount);
        addressMintedBalance[msg.sender] = addressMintedBalance[msg.sender].add(
            _mintAmount
        );
        for (uint8 i = 0; i < _mintAmount; i++) {
            _safeMint(msg.sender, _nextTokenId._value);
            Counters.increment(_nextTokenId);
        }

        //Please make sure you check the following things:
        //Current state is available for Public Mint
        //Check how many NFTs are available to be minted
        //Check user has sufficient funds
    }

    // Implement totalSupply() Function to return current total NFT being minted - week 8
    function getTotalSupply() external view returns (uint256) {
        return totalSupply;
    }

    // Implement withdrawBalance() Function to withdraw funds from the contract - week 8
    function withdrawBalance() external onlyOwner {
        (bool sent, ) = msg.sender.call{value: address(this).balance}("");
        if (!sent) {
            revert("withdraw error");
        }
    }

    // Implement setPrice(price) Function to set the mint price - week 8
    function setPrice(uint256 _price) external onlyOwner {
        price = _price;
    }

    // Implement toggleMint() Function to toggle the public mint available or not - week 8
    function toggleMint() external onlyOwner {
        mintActive = !mintActive;
    }

    // Set mint per user limit to 10 and owner limit to 20 - Week 8
    function setMaxBalance() internal {
        addressMaxBalance[msg.sender] = msg.sender == owner() ? 20 : 10;
    }

    // Implement toggleReveal() Function to toggle the blind box is revealed - week 9

    // Implement setBaseURI(newBaseURI) Function to set BaseURI - week 9

    // Function to return the base URI
    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    // Early mint function for people on the whitelist - week 9
    function earlyMint(bytes32[] calldata _merkleProof, uint256 _mintAmount)
        public
        payable
    {
        //Please make sure you check the following things:
        //Current state is available for Early Mint
        //Check how many NFTs are available to be minted
        //Check user is in the whitelist - use merkle tree to validate
        //Check user has sufficient funds
    }

    // Implement toggleEarlyMint() Function to toggle the early mint available or not - week 9

    // Implement setMerkleRoot(merkleRoot) Function to set new merkle root - week 9

    // Let this contract can be upgradable, using openzepplin proxy library - week 10
    // Try to modify blind box images by using proxy
}
