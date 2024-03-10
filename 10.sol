// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataStorage {

    // Define a struct to store the three key-value pairs for value
    struct Data {
        int256[] grad;
        int256[] beta;
        int256[] sigma;
    }

    // Use a mapping to store the key and its corresponding Data, and set it to private
    mapping(int256 => Data) private dataStore;

    // Manually create getter functions
    function getGrad(int256 key) public view returns (int256[] memory) {
        return dataStore[key].grad;
    }

    function getBeta(int256 key) public view returns (int256[] memory) {
        return dataStore[key].beta;
    }

    function getSigma(int256 key) public view returns (int256[] memory) {
        return dataStore[key].sigma;
    }

    // Store data
    function storeData(int256 key, int256[] memory grad, int256[] memory beta, int256[] memory sigma) public {
        // Check if all three arrays have the same length
        require(grad.length == beta.length && grad.length == sigma.length, "All arrays must have the same length");

        Data storage entry = dataStore[key];
        entry.grad = grad;
        entry.beta = beta;
        entry.sigma = sigma;
    }

    // Add the arrays of multiple keys and return the result
    function addArrays(int256[] memory keys) public view returns (int256[] memory resultGrad, int256[] memory resultBeta, int256[] memory resultSigma) {
        require(keys.length > 0, "At least one key is required");

        uint256 length = dataStore[keys[0]].grad.length;

        // Check if all keys have arrays of the same length
        for (uint256 k = 0; k < keys.length; k++) {
            require(dataStore[keys[k]].grad.length == length, "Array length mismatch among keys");
            require(dataStore[keys[k]].beta.length == length, "Array length mismatch among keys");
            require(dataStore[keys[k]].sigma.length == length, "Array length mismatch among keys");
        }

        resultGrad = new int256[](length);
        resultBeta = new int256[](length);
        resultSigma = new int256[](length);

        for (uint256 i = 0; i < length; i++) {
            for (uint256 k = 0; k < keys.length; k++) {
                resultGrad[i] += dataStore[keys[k]].grad[i];
                resultBeta[i] += dataStore[keys[k]].beta[i];
                resultSigma[i] += dataStore[keys[k]].sigma[i];
            }
        }
    }


    function calculateAndStoreSquareSum(int256 key) public view returns (int256) {
        int256 sum = 0;

        int256[] memory gradData = dataStore[key].grad;

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
        int256[] memory betaData = dataStore[key].beta;

        for (uint256 i = 0; i < betaData.length; i++) {
            int256 reducedValue = betaData[i]  / 1e20;
            int256 squaredValue = reducedValue*reducedValue;
            
            sum += squaredValue;
        }

        for (uint256 i = 0; i < betaData.length; i++) {
            int256 reducedValue = betaData[i]  / 1e20;
            int256 squaredValue = reducedValue*reducedValue;
            
            sum += squaredValue;
        }
        int256[] memory sigmaData = dataStore[key].sigma;

        for (uint256 i = 0; i < sigmaData.length; i++) {
            int256 reducedValue = sigmaData[i]  / 1e20;
            int256 squaredValue = reducedValue*reducedValue;
            
            sum += squaredValue;
        }

        for (uint256 i = 0; i < sigmaData.length; i++) {
            int256 reducedValue = sigmaData[i]  / 1e20;
            int256 squaredValue = reducedValue*reducedValue;
            
            sum += squaredValue;
        }
        return sum;
    }

    // Utility function to compute the sum of squares for a processed array
    function processAndSumOfSquares(int256[] memory arr) private pure returns (int256) {
        int256 sum = 0;
        for (uint256 i = 0; i < arr.length; i++) {
            int256 processedValue = arr[i] / 10**19;  // Divide by 10^19
            sum += processedValue * processedValue;   // Square and sum
        }
        return sum;
    }

    // Function to compute the sum of squares for processed grad, beta, and sigma for a range of keys
    function computeSumOfSquaresInRange(int256 startKey, int256 endKey) public view returns (int256 gradSum, int256 betaSum, int256 sigmaSum) {
        for (int256 key = startKey; key <= endKey; key++) {
            gradSum += processAndSumOfSquares(dataStore[key].grad);
            betaSum += processAndSumOfSquares(dataStore[key].beta);
            sigmaSum += processAndSumOfSquares(dataStore[key].sigma);
        }
    }
}
