// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.9;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract AppWorksUpgradeableV1 is ERC721Upgradeable, OwnableUpgradeable, UUPSUpgradeable {
    // an uint256 variable can call up functions in the Strings library. One example can be, value.toString(). An uint256 can be easily converted into a string.
    using StringsUpgradeable for uint256;

    // Provides counters that can only be incremented, decremented or reset. This can be used e.g. to track the number of elements in a mapping, issuing ERC721 ids, or counting request ids.
    using Counters for Counters.Counter;
    Counters.Counter private _nextTokenId;

    uint256 public price;
    uint256 public constant maxSupply = 100;
    uint256 public totalSupply;

    bool public mintActive;
    bool public earlyMintActive;
    bool public revealed;

    string public baseURI;
    string public blindURI;
    bytes32 public merkleRoot;

    mapping(uint256 => string) private _tokenURIs;
    mapping(address => uint256) public addressMintedBalance;

    // Upgradeable 無法使用 constructor
    // constructor() ERC721Upgradeable("AppWorks", "AW") {}
    function initialize() public initializer {
        __ERC721_init("AppWorks", "AW");
        __Ownable_init();
        __UUPSUpgradeable_init();
        price = 0.01 ether;
        blindURI = "https://buyway.hk/img/pic_34/4580607843690.jpg?w=688";
    }

    // Public mint function - week 8
    function mint(uint256 _mintAmount) public payable {
        require(mintActive, "Not valid mint time");
        require(
            maxBalance() - addressMintedBalance[msg.sender] >= _mintAmount,
            "Over balance"
        );
        require(
            totalSupply + _mintAmount <= maxSupply,
            "Reach max supply amount"
        );
        require(msg.value == price * _mintAmount, "Mismatch value");

        totalSupply += _mintAmount;
        addressMintedBalance[msg.sender] += _mintAmount;
        for (uint8 i = 0; i < _mintAmount; i++) {
            _safeMint(msg.sender, _nextTokenId._value);
            _nextTokenId.increment();
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
    function maxBalance() internal view returns (uint256) {
        return msg.sender == owner() ? 20 : 10;
    }

    // Implement toggleReveal() Function to toggle the blind box is revealed - week 9
    function toggleReveal() external onlyOwner {
        revealed = !revealed;
    }

    // Implement setBaseURI(newBaseURI) Function to set BaseURI - week 9
    function setBaseURI(string calldata _newBaseURI) external onlyOwner {
        baseURI = _newBaseURI;
    }

    // Function to return the base URI
    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        _requireMinted(tokenId);

        if (revealed){
            string memory _URI = _baseURI();
            return bytes(_URI).length > 0 ? string(abi.encodePacked(_URI, tokenId.toString())) : "";
        }else{
            return blindURI;
        }
    }

    // Early mint function for people on the whitelist - week 9
    function earlyMint(bytes32[] calldata _merkleProof, uint256 _mintAmount)
        public
        payable
    {
        require(earlyMintActive, "Not valid early mint time");
        require(merkleRoot != bytes32(0), "Haven't set whitelist yet");
        require(
            MerkleProof.verify(
                _merkleProof,
                merkleRoot,
                keccak256(abi.encodePacked(msg.sender))
            ),
            "Not in whitelist"
        );
        require(
            maxBalance() - addressMintedBalance[msg.sender] >= _mintAmount,
            "Over balance"
        );
        require(
            totalSupply + _mintAmount <= maxSupply,
            "Reach max supply amount"
        );
        require(msg.value == price * _mintAmount, "Mismatch value");

        totalSupply += _mintAmount;
        addressMintedBalance[msg.sender] += _mintAmount;
        for (uint8 i = 0; i < _mintAmount; i++) {
            _safeMint(msg.sender, _nextTokenId._value);
            _nextTokenId.increment();
        }
        
        //Please make sure you check the following things:
        //Current state is available for Early Mint
        //Check how many NFTs are available to be minted
        //Check user is in the whitelist - use merkle tree to validate
        //Check user has sufficient funds
    }

    // Implement toggleEarlyMint() Function to toggle the early mint available or not - week 9
    function toggleEarlyMint() external onlyOwner {
        earlyMintActive = !earlyMintActive;
    }

    // Implement setMerkleRoot(merkleRoot) Function to set new merkle root - week 9
    // 驗證邏輯
    // 1. 根據所有白名單地址計算出 Merkle Root，並設置到合約中
    // 2. 前端會根據用戶地址請求後端獲取對應 Merkle Proof
    // 3. 將 Proof 傳入合約進行校驗
    function setMerkleRoot(bytes32 _merkleRoot) external onlyOwner {
        merkleRoot = _merkleRoot;
    }

    // Let this contract can be upgradable, using openzepplin proxy library - week 10
    // Try to modify blind box images by using proxy
    function _authorizeUpgrade(address newImplementation)
        internal
        onlyOwner
        override
    {}
}

// 0x7508DB5edbE08BC20478B6fED6d6A3AB4e4cd27F
// 0x5D13651FCA3FC031Cb25cf9c66f6163755a4712E

// proxy: 0xE01Ba69E255b9FA7E2aDaa29Dc4FCF73Fda078Bc
// implementation: 0x7513482Ad57AB45e0e64f9CC7307E2459a3345F0