// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

contract Square {
    function square(uint256 n) public pure returns (uint256) {
        require(n <= n**128, "n is too large");
        return n * n;
    }
}

contract SquareTest is Test {
    Square public squareContract;

    function setUp() public {
        squareContract = new Square();
    }

    function testSquare(uint256 n) public {
        assertEq(squareContract.square(n), n * n);
    }
}
