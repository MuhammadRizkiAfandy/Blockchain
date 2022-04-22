pragma solidity ^0.6.0;

contract helloWorld{

    uint256 totalCoin;
    
    function addCoin(uint256 nCoin) public{
        totalCoin += nCoin;
    }

    function viewTotalCoin() public view returns(uint){
        return totalCoin;
    }
}
