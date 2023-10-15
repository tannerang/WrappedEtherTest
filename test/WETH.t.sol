// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Test, console2} from "forge-std/Test.sol";
import {WETH} from "../src/WETH.sol";

contract WrappedEtherTest is Test {

    WETH public myContract;
    event Deposit(address indexed account, uint amount);
    event Withdraw(address indexed account, uint amount);

    function setUp() public {
        myContract = new WETH();
    }

    function testCase01_CheckBalanceOfUser() public {
        address user1 = makeAddr("user1");
        vm.startPrank(user1);
        deal(user1, 10 ether);
        (bool success,) = address(myContract).call{value: 10 ether}('');
        require(success, "Fail to call.");
        assertEq(myContract.balanceOf(user1), 10 ether);
        vm.stopPrank();
    }

    function testCase02_CheckContractBalance() public {
        address user1 = makeAddr("user1");
        vm.startPrank(user1);
        deal(user1, 10 ether);
        (bool success,) = address(myContract).call{value: 10 ether}('');
        require(success, "Fail to call.");
        assertEq(address(myContract).balance, 10 ether);
        vm.stopPrank();
    }

    function testCase03_CheckDepositEvent() public {
        address user1 = makeAddr("user1");
        vm.startPrank(user1);
        deal(user1, 10 ether);

        vm.expectEmit(true,false,false,false);
        emit Deposit(user1, 10 ether);
        (bool success,) = address(myContract).call{value: 10 ether}('');
        require(success, "Fail to call.");
        vm.stopPrank();
    }

    function testCase04_CheckWithdrawBurnedToken() public {
        address user1 = makeAddr("user1");
        vm.startPrank(user1);
        deal(user1, 10 ether);
        (bool success,) = address(myContract).call{value: 10 ether}('');
        require(success, "Fail to call.");
        assertEq(address(myContract).balance, 10 ether);

        myContract.withdraw(10 ether);
        assertEq(address(myContract).balance, 0 ether);
        assertEq(myContract.balanceOf(user1), 0 ether);
        vm.stopPrank();
    } 

    function testCase05_CheckWithdrawUserBalance() public {
        address user1 = makeAddr("user1");
        vm.startPrank(user1);
        deal(user1, 10 ether);
        (bool success,) = address(myContract).call{value: 10 ether}('');
        require(success, "Fail to call.");
        assertEq(address(myContract).balance, 10 ether);

        myContract.withdraw(10 ether);
        assertEq(address(user1).balance, 10 ether);
        vm.stopPrank();
    } 

    function testCase06_CheckWithdrawEvent() public {
        address user1 = makeAddr("user1");
        vm.startPrank(user1);
        deal(user1, 10 ether);
        (bool success,) = address(myContract).call{value: 10 ether}('');
        require(success, "Fail to call.");
        assertEq(address(myContract).balance, 10 ether);

        vm.expectEmit(true,false,false,false);
        emit Withdraw(user1, 10 ether);
        myContract.withdraw(10 ether);

        vm.stopPrank();
    } 

    function testCase07_CheckTransfer() public {
        address user1 = makeAddr("user1");
        address user2 = makeAddr("user2");

        vm.startPrank(user1);
        deal(user1, 10 ether);
        (bool success,) = address(myContract).call{value: 10 ether}('');
        require(success, "Fail to call.");
        assertEq(address(myContract).balance, 10 ether);

        myContract.transfer(user2, 10 ether);
        assertEq(myContract.balanceOf(user1), 0 ether);
        assertEq(myContract.balanceOf(user2), 10 ether);
        vm.stopPrank();
    }

    function testCase08_CheckApproveAllowance() public {
        address user1 = makeAddr("user1");
        address user2 = makeAddr("user2");

        vm.startPrank(user1);
        deal(user1, 10 ether);
        (bool success,) = address(myContract).call{value: 10 ether}('');
        require(success, "Fail to call.");

        myContract.approve(user2, 10 ether);
        uint256 allowance = myContract.allowance(user1, user2);
        assertEq(allowance, 10 ether);
        vm.stopPrank();
    }

    function testCase09_CheckTransferFrom() public {
        address user1 = makeAddr("user1");
        address user2 = makeAddr("user2");
        address user3 = makeAddr("user3");

        vm.startPrank(user1);
        deal(user1, 10 ether);
        (bool success,) = address(myContract).call{value: 10 ether}('');
        require(success, "Fail to call.");
        myContract.approve(user2, 10 ether);
        vm.stopPrank();

        vm.startPrank(user2);
        myContract.transferFrom(user1, user3, 7 ether);
        assertEq(myContract.balanceOf(user3), 7 ether);
        vm.stopPrank();
    }

    function testCase10_CheckTransferFromAllowance() public {
        address user1 = makeAddr("user1");
        address user2 = makeAddr("user2");
        address user3 = makeAddr("user3");

        vm.startPrank(user1);
        deal(user1, 10 ether);
        (bool success,) = address(myContract).call{value: 10 ether}('');
        require(success, "Fail to call.");
        myContract.approve(user2, 10 ether);
        vm.stopPrank();

        vm.startPrank(user2);
        myContract.transferFrom(user1, user3, 7 ether);
        uint256 allowance = myContract.allowance(user1, user2);
        assertEq(allowance, 3 ether);        
        vm.stopPrank();
    }
}
