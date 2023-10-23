// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract testHelper {
    function getETH(address _addr) public view returns(uint256){
        return address(_addr).balance;
    }
}