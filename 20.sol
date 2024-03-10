// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MerkleProofStorage {
    
    // 存储Merkle root值
    bytes32 public merkleRoot;

    // 设置Merkle root的值
    function setMerkleRoot(bytes32 _merkleRoot) external {
        merkleRoot = _merkleRoot;
    }
}
