// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 需要确保 Lagrange.sol 已经部署，并且 Lagrange_cha 的接口已知
import "./Lagrange.sol";

contract OmPlus3 {
    // 存储 Merkle Root 和两个数字
    bytes32 public merkleRoot;
    uint256 public num1;
    uint256 public num2;
    uint256[4] fCommitment;

    // 定义 Commitment 结构
    struct Commitment {
        uint256[4] numbers;
    }

    // 定义 VerifyInfo 结构
    struct VerifyInfo {
        uint256[5] outputWires;
        uint256[5] sigmas;
    }

    // 将可见性更改为 private
    Commitment[] private commitments;
    VerifyInfo[] private verifyInfos;
    uint256 public r;


    function storeMerkleRootAndNumbers(bytes32 _merkleRoot, uint256 _num1, uint256 _num2) external {
        merkleRoot = _merkleRoot;
        num1 = _num1;
        num2 = _num2;
    }

    function storeCommitments(Commitment[] memory _commitments) external {
        for(uint i = 0; i < _commitments.length; i++) {
            commitments.push(_commitments[i]);
        }
    }

    function storeVerifyInfosAndR(VerifyInfo[] memory _verifyInfos, uint256 _r) external {
        for(uint i = 0; i < _verifyInfos.length; i++) {
            verifyInfos.push(_verifyInfos[i]);
        }
        r = _r;
    }

    function calculateFinalCommitment() external returns (uint256[4] memory) {
        uint256[4] memory finalCommitment = [uint256(1), 1, 1, 1]; // 初始化为1
        for (uint i = 0; i < commitments.length; i++) {
            for (uint j = 0; j < 4; j++) {
                finalCommitment[j] *= commitments[i].numbers[j];
            }
        }
        // 存储最终的 commitment
        fCommitment = finalCommitment;
        return finalCommitment;
    }



}
