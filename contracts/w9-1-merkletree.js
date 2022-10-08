const { MerkleTree } = require('merkletreejs');
const keccak256 = require('keccak256');
let whitelistAddresses = [
    "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",
    "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",
    "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db",
    "0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB",
    "0x8F93d809B935B61Eb71E4158222432Bbd629f462"
]

// 計算 leaf 葉子節點的數據
const leafNodes = whitelistAddresses.map(addr => keccak256(addr));
// 生成 Merkle Tree
const merkleTree = new MerkleTree(leafNodes, keccak256, { sortPairs: true });

// 獲取 Merkle Root
const rootHash = merkleTree.getRoot();

// 查看 Merkle Tree 全部數據
console.log('Whitelist Merkle Tree\n', merkleTree.toString());

// 查看 Root 數據，需要設置到合約中
console.log("Root Hash: ", rootHash.toString('hex'));
// (0x)63388949bfe070ca92e2ec7b4d0eaaec5207fb4b2c57bb97e52e3626a880da30

// 選擇一個白名單地址進行校驗
// claimingAddress 地址 hash 之後，透過 merkleTree.getHexProof 就可以拿到對應地址的 Merkle Proof
const claimingAddress = keccak256("0x5B38Da6a701c568545dCfcB03FcB875f56beddC4");
console.log('hash 後的地址', claimingAddress)
// <Buffer 59 31 b4 ed 56 ac e4 c4 6b 68 52 4c b5 bc bf 41 95 f1 bb aa cb e5 22 8f bd 09 05 46 c8 8d d2 29>

// 計算這個地址的 Merkle Proof，這就是我們要傳給合約的參數 Proof
const hexProof = merkleTree.getHexProof(claimingAddress);
console.log('hexProof', hexProof);
// ["0x999bf57501565dbd2fdcea36efa2b9aef8340a8901e3459f4a4c926275d36cdb","0x4726e4102af77216b09ccd94f40daa10531c87c4d60bba7f3b3faf5ff9f19b3c","0xc77066c19b78777a3bba8da8768a35393328c5974a50e842f426a52eaddc991c"]

// 校驗
console.log(merkleTree.verify(hexProof, claimingAddress, rootHash));