pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";
import {NonMatchingSelectorHelper} from "./test-utils/NonMatchingSelectorHelper.sol";

interface ToggleBitAt {
    function toggleBitAt(uint256 number, uint8 bitIndex) external pure returns (uint256);
}

contract ToggleBitAtTest is Test, NonMatchingSelectorHelper {
    ToggleBitAt public toggleBitAt;

    function setUp() public {
        toggleBitAt = ToggleBitAt(HuffDeployer.config().deploy("ToggleBitAt"));
    }

    // Test ToggleBitAt function
    function testToggleBitAt() public {
        // Test Case 1
        assertEq(toggleBitAt.toggleBitAt(157, 2), 153, "Incorrect result for Test Case 1");

        // Test Case 2
        assertEq(toggleBitAt.toggleBitAt(0, 0), 1, "Incorrect result for Test Case 2");

        // Test Case 3
        assertEq(toggleBitAt.toggleBitAt(255, 7), 127, "Incorrect result for Test Case 3");

        // Test Case 4
        assertEq(toggleBitAt.toggleBitAt(5, 1), 7, "Incorrect result for Test Case 4");

        // Test Case 5
        assertEq(toggleBitAt.toggleBitAt(16, 3), 24, "Incorrect result for Test Case 5");
    }

    /// @notice Test that a non-matching selector reverts
    function testNonMatchingSelector(bytes32 callData) public {
        bytes4[] memory func_selectors = new bytes4[](1);
        func_selectors[0] = ToggleBitAt.toggleBitAt.selector;

        bool success = nonMatchingSelectorHelper(
            func_selectors,
            callData,
            address(toggleBitAt)
        );
        assert(!success);
    }
}

