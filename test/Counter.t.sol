// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {BLCToken} from "../src/Counter.sol";

contract CounterTest is Test {
    BLCToken public counter;

    function setUp() public {
        counter = new BLCToken();
    }
}
