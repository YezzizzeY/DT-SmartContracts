// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleContract {
    
    // 定义数据结构element
    struct Element {
        uint256 data1;
        uint256 data2;
        uint256 data3;
    }
    
    // 合约中存储的element数组
    Element[] public elements;

    // 合约中存储的commitment数组
    Element[][] public commitments; // 修改为动态数组

    // 函数：存储一个element并存储5个element作为commitment
    function storeElementAndCommitment(
        uint256 _data1, 
        uint256 _data2, 
        uint256 _data3
    ) public {
        // 存储element
        Element memory newElement = Element(_data1, _data2, _data3);
        elements.push(newElement);

        // 生成并存储commitment
        commitments.push();  // Create a new sub-array
        uint256 lastCommitmentIndex = commitments.length - 1;
        for (uint i = 0; i < 5; i++) {
            commitments[lastCommitmentIndex].push(newElement);
        }
    }
}
