// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GradientContract {
    struct Gradient {
        uint256 alpha;
        uint256 beta;
        uint256 gama;
    }

    // 用于存储所有用户的gradients，每个用户标识符对应一个独立的数组
    mapping(uint256 => Gradient[]) public userGradients;

    // 允许用户上传一系列的gradients，使用用户标识符
    function uploadGradients(uint256 userId, Gradient[] memory gradients) public {
        for(uint256 i = 0; i < gradients.length; i++) {
            userGradients[userId].push(gradients[i]);
        }
    }

    // 计算并返回最终的gradients聚合
    function calculateFinalGradients() public returns (Gradient[] memory) {
        // 首先，确定最大的gradients数组长度
        uint256 maxLength = 0;
        for(uint256 userId = 1; userGradients[userId].length > 0; userId++) {
            if(userGradients[userId].length > maxLength) {
                maxLength = userGradients[userId].length;
            }
        }

        // 初始化聚合结果数组
        Gradient[] memory finalGradients = new Gradient[](maxLength);
        for (uint256 i = 0; i < maxLength; i++) {
            finalGradients[i] = Gradient(0, 0, 0);
        }

        // 遍历所有用户，计算每个gradient位置的聚合
        for(uint256 userId = 1; userGradients[userId].length > 0; userId++) {
            for (uint256 i = 0; i < userGradients[userId].length; i++) {
                finalGradients[i].alpha += userGradients[userId][i].alpha;
                finalGradients[i].beta += userGradients[userId][i].beta;
                finalGradients[i].gama += userGradients[userId][i].gama;
            }
        }

        return finalGradients;
    }
}
