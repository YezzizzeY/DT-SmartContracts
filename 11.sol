// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataProcessing {

    struct Data {
        int256[] grad;
        int256[] beta;
        int256[] sigma;
    }

    mapping(uint256 => Data) private dataStore;
    mapping(uint256 => int256) private squareSums;  // 存储每一个key对应的平方和
    uint256 private currentKey = 1;

    function storeData(int256[] memory grad, int256[] memory beta, int256[] memory sigma) public {
        Data storage entry = dataStore[currentKey];
        entry.grad = grad;
        entry.beta = beta;
        entry.sigma = sigma;
        currentKey++;
    }

    function calculateAndStoreSquareSum(uint256 key) public {
        require(key < currentKey, "Invalid key provided.");

        int256[] memory gradData = dataStore[key].grad;

        int256 sum = 0;
        for (uint256 i = 0; i < gradData.length; i++) {
            int256 reducedValue = gradData[i]  / 1e20;
            int256 squaredValue = reducedValue*reducedValue;
            
            sum += squaredValue;
        }

        for (uint256 i = 0; i < gradData.length; i++) {
            int256 reducedValue = gradData[i]  / 1e20;
            int256 squaredValue = reducedValue*reducedValue;
            
            sum += squaredValue;
        }

        squareSums[key] = sum;  // 保存平方和到squareSums中
    }

    function getSquareSum(uint256 key) public view returns (int256) {
        return squareSums[key];
    }

    function getCurrentKey() public view returns (uint256) {
        return currentKey - 1;
    }
}
