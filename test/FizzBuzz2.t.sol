// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "openzeppelin-contracts/contracts/utils/Strings.sol";

contract FizzBuzz2 {
    mapping(uint256 => address) public poohStore;
    string[] public fizzbuzzList;

    function run(uint256 start, uint256 end) public returns (string memory) {
        require(start <= end, "start is greater than end");
        for (uint256 i = start; i <= end; i++) {
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
        }

        string memory result = "";
        for (uint256 j = 0; j < fizzbuzzList.length; j++) {
            string memory encoded = string.concat(fizzbuzzList[j], "\n");
            result = string.concat(result, encoded);
        }

        delete fizzbuzzList;
        return string(result);
    }
}

contract FizzBuzz2Test is Test {
    FizzBuzz2 public fizzBuzzContract;

    function setUp() public {
        fizzBuzzContract = new FizzBuzz2();
    }

    function testFizzBuzz() public {
        assertEq(
            fizzBuzzContract.run(1, 15),
            "1\n2\nFizz\n4\nBuzz\nFizz\n7\n8\nFizz\nBuzz\n11\nFizz\n13\n14\nFizzBuzz\n"
        );
    }
}
