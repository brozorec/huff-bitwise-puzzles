// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";
import {NonMatchingSelectorHelper} from "./test-utils/NonMatchingSelectorHelper.sol";

interface TurnOnBitAt {
    function turnOnBitAt(uint256 number, uint8 bitIndex) external pure returns (uint256);
}

contract TurnOnBitAtIndexTest is Test, NonMatchingSelectorHelper {
    TurnOnBitAt public turnOnBitAt;

    function setUp() public {
        turnOnBitAt = TurnOnBitAt(HuffDeployer.config().deploy("TurnOnBitAt"));
    }

    // Test TurnOnBitAtIndex function
    function testTurnOnBitAtIndex() public {
        // Test Case 1
        assertEq(turnOnBitAt.turnOnBitAt(8, 1), 10, "Incorrect result for Test Case 1");

        // Test Case 2
        assertEq(turnOnBitAt.turnOnBitAt(0, 0), 1, "Incorrect result for Test Case 2");

        // Test Case 3
        assertEq(turnOnBitAt.turnOnBitAt(255, 7), 255, "Incorrect result for Test Case 3");

        // Test Case 4
        assertEq(turnOnBitAt.turnOnBitAt(5, 1), 7, "Incorrect result for Test Case 4");

        // Test Case 5
        assertEq(turnOnBitAt.turnOnBitAt(16, 4), 16, "Incorrect result for Test Case 5");
    }

    /// @notice Test that a non-matching selector reverts
    function testNonMatchingSelector(bytes32 callData) public {
        bytes4[] memory func_selectors = new bytes4[](1);
        func_selectors[0] = TurnOnBitAt.turnOnBitAt.selector;

        bool success = nonMatchingSelectorHelper(
            func_selectors,
            callData,
            address(turnOnBitAt)
        );
        assert(!success);
    }
}

