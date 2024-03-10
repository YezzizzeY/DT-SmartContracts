pragma solidity >=0.7.0 <0.9.0;

pragma solidity ^0.8.0;

contract IntegerDivision {
    
    function divideByTenPowerNineteen(int256 input) public pure returns (int256) {
        return input / 1e20 +1;
    }
}
