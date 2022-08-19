// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "openzeppelin-contracts/contracts/utils/Strings.sol";

contract FizzBuzz {
    mapping(uint256 => address) public poohStore;
    string[] public fizzbuzzList;

    function run(uint256 i) public returns (string memory) {
        if (i % 15 == 0) {
            poohStore[i] = msg.sender;
            fizzbuzzList.push("FizzBuzz");
        } else if (i % 3 == 0) {
            poohStore[i] = msg.sender;
            fizzbuzzList.push("Fizz");
        } else if (i % 5 == 0) {
            poohStore[i] = msg.sender;
            fizzbuzzList.push("Buzz");
        } else {
            poohStore[i] = msg.sender;
            fizzbuzzList.push(Strings.toString(i));
        }

        string memory result = "";
        for (uint256 j = 0; j < fizzbuzzList.length; j++) {
            result = string.concat(result, string.concat(fizzbuzzList[j]));
        }

        delete fizzbuzzList;
        return string(result);
    }
}

contract FizzBuzzTest is Test {
    FizzBuzz public fizzBuzzContract;

    function setUp() public {
        fizzBuzzContract = new FizzBuzz();
    }

    function testFizzBuzz() public {
        assertEq(fizzBuzzContract.run(1), "1");
        assertEq(fizzBuzzContract.run(3), "Fizz");
        assertEq(fizzBuzzContract.run(5), "Buzz");
        assertEq(fizzBuzzContract.run(15), "FizzBuzz");
    }
}
