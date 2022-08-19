// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "openzeppelin-contracts/contracts/utils/Strings.sol";

contract FizzBuzz {
    struct Pooh {
        string text;
    }
    mapping(string => Pooh) public poohStore;
    string[] public fizzbuzzList;

    function run(uint256 i) public returns (string memory) {
        require(i >= 0, "i is less than 0");

        if (i % 15 == 0) {
            calculateText(i, safeFizzBuzzText("FizzBuzz"));
        } else if (i % 3 == 0) {
            calculateText(i, safeFizzText("Fizz"));
        } else if (i % 5 == 0) {
            calculateText(i, safeBuzzText("Buzz"));
        } else {
            calculateText(i, Strings.toString(i));
        }

        string memory result = createResponse();

        delete fizzbuzzList;
        return string(result);
    }

    function getPoohText(uint256 i) public view returns (string memory) {
        return poohStore[Strings.toString(i)].text;
    }

    function calculateText(uint256 i, string memory t)
        public
        returns (string memory)
    {
        Pooh memory pooh;
        pooh.text = t;
        string memory idx = Strings.toString(i);
        poohStore[idx] = pooh;
        fizzbuzzList.push(poohStore[idx].text);
        return "";
    }

    function createResponse() public view returns (string memory) {
        string memory result = "";
        for (uint256 j = 0; j < fizzbuzzList.length; j++) {
            result = string.concat(result, string.concat(fizzbuzzList[j]));
        }
        return result;
    }

    function safeFizzBuzzText(string memory t)
        public
        pure
        returns (string memory)
    {
        require(isSame(t, "FizzBuzz"), "t is not FizzBuzz");
        return t;
    }

    function safeFizzText(string memory t) public pure returns (string memory) {
        require(isSame(t, "Fizz"), "t is not Fizz");
        return t;
    }

    function safeBuzzText(string memory t) public pure returns (string memory) {
        require(isSame(t, "Buzz"), "t is not Buzz");
        return t;
    }

    function isSame(string memory a, string memory b)
        public
        pure
        returns (bool)
    {
        return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
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
