// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/ClaimRewards.sol";

// analysis: https://www.levi104.com/2023/07/05/08.PoC/01.Phishing%20scam/
// twitter: https://twitter.com/salus_sec/status/1679331500452634624

contract PhishingTest is Test {

    ClaimRewards claimRewards;
    address user = 0xd3E65149C212902749D49011B6ab24bba30D97c6;

    function setUp() public {
        claimRewards = new ClaimRewards();
        deal(user, 11 ether);
        targetContract(address(claimRewards));
        targetSender(user);

        vm.startBroadcast(user);
        claimRewards.Claim{value: 5 ether}();
        claimRewards.Gift{value: 6 ether}();
        vm.stopBroadcast();
    }

    function invariant_withdrawMoney() public{
        // 如果测试通过，说明无法取出钱，说明是钓鱼合约
        require(address(user).balance == 0);
    }

}
